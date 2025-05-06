Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD50C3ABB6
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 02:19:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 259DE10E157;
	Tue,  6 May 2025 02:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vnybJwhT";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51EE410E157
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 02:19:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KopUFueKuHzXc4zNkJpgXjdtuWfnvTfagqRy1NYuAeoCubL2c4WYXOTe9sqfVuPypWfR4yxmWbDX0FeS7sJoutdbwWCMNaHeJ9+6fsNtJPNU1YUxMAaiLzRhJtzfEl+3Vpl14CpKmE/FGo22xeGVfLJFZZfz7TFU4TQ7opH4o+c3iy2yALnu7Ln5xZa9Y7ryaMDAnqNDd44VKeLl+qh6cGz+pQb7IA3NhLczbaLed2m1mKIVn9p8DoK4aiyvetOuQSmQwGxGqNEAB23QIsEdLSrzPQQw7o3sdV7Fsy+/Er/rozogqtyWMqw9Yc+T6A/wdMd4w0AGfE4LHTW4hUADPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50n7laqNoQH0o7OPFWWPhYu4L1Vj6tmsTlxj4j6m9sc=;
 b=wARKIOv36z5Nuv/S15NYV6OgDTruiv/l7t9C5FpBqbXeSvsCA4juWY33JVCDiAF1I8i/AR/KRh1pvbd9qX/dXTEJUjmbLNvtkjbbzqIL95gzyZJsR9pN3nIkQuS6tRsDnXkufgs2oUsUGQC1pcwGqruN6h/+3GFOdVTUfDNFU4POkBE9T948G61YfRlXPuDMTRxDj0r3EsVT+bYa5l0a8VLBvGX0AiVrqsx1wj9eoTuki9cwWu8PWtg9d37hkZAkkycChGgIsroKdiuqAmTnP29XmTfnJpyESFzMDPq3G98xg8pzscyFyhqVbUagz4/tuglgu+qkG/6nCM9684+2XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50n7laqNoQH0o7OPFWWPhYu4L1Vj6tmsTlxj4j6m9sc=;
 b=vnybJwhTxKsqYJDzgB0CV2w7DvZ/0v1B6v3zpBN3QFLThVeGg2gnfT2QqgIPT8afQitst1X0Geil22ZnxAy4ew2IyOFFWGKvvYqpuEIMbkk5I5MLGQELS4p0NHTJNCPBv6RElxgmJEqkaMdsXyweQibnjOHOdl18PcSVLwX6qxU=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 PH7PR12MB6955.namprd12.prod.outlook.com (2603:10b6:510:1b8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.23; Tue, 6 May 2025 02:19:13 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%4]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 02:19:13 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v3 3/5] drm/amdgpu: fix the eviction fence dereference
Thread-Topic: [PATCH v3 3/5] drm/amdgpu: fix the eviction fence dereference
Thread-Index: AQHbuXlWR+Mh1AtXUkqLNaxozVn83bO8G1gAgAjKtWA=
Date: Tue, 6 May 2025 02:19:13 +0000
Message-ID: <DS7PR12MB600548A81FE6C675FA062376FB892@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20250430024054.4093239-1-Prike.Liang@amd.com>
 <20250430024054.4093239-3-Prike.Liang@amd.com>
 <5f08bb2d-e9c4-4d0d-b333-baf0355c23af@amd.com>
In-Reply-To: <5f08bb2d-e9c4-4d0d-b333-baf0355c23af@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4b249e16-230e-4c02-ad01-e3f4db71826f;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-05-06T02:13:59Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|PH7PR12MB6955:EE_
x-ms-office365-filtering-correlation-id: f91241a2-f35c-4de2-9634-08dd8c446517
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?OS9MZitJeGVqcFRNdjQ0bDRvenYveTlQdmU1N3VyNzVRb3d4eG1TeTN3TlAw?=
 =?utf-8?B?dTBSYThZSHFIOXllVkI4WGV3L3pCNEN3RDlJQjYrTnkxbW5kbUxZa0ZvQXEw?=
 =?utf-8?B?UTNhVUVtWWZiQk1KUFgrSWllcEJUUHpWK0VPSWFONnQvMlMxVzFPOHo3UWVK?=
 =?utf-8?B?MzhCQW0rZXg0WmJHRUo5THkrQWNnaEZoRXdCS05YZmkrV2JOdUJNbnljOUE0?=
 =?utf-8?B?ZnAvaDZDMmQ2K3JMY2wvSTN0cndPVEx6UC9XMDdpdGhaVkVXTHJtWW5kZDgy?=
 =?utf-8?B?V1E3aU0yam1nb0tsSTVoSXRCSFZrRGlURGFRZEM0RmlWemhHUk8ya3BBUVh5?=
 =?utf-8?B?Z0lhNGVnZnk1eWc0cFVQT2J4bmt2dUx5R3RCb3FDenFWL05ZTHBsa2ovZVdK?=
 =?utf-8?B?SWlqaUhKbFZRSVgrODJiaWNFWGNNOVkrbHFoVThhSlhCVFE4R3dlOFFGSjF1?=
 =?utf-8?B?cFh2ZFI2S3Z5MW5rd05tSnRuL0tRWVEyWCtwVy9qT3ZsQXZtVnpHUjdiSkdU?=
 =?utf-8?B?YnVQRGttdnNrS2pjQlFFcFZkcXFUc3A1Z3FETXg1a2VxYU9ndVltaTdnMTVE?=
 =?utf-8?B?NWlmSFVNcGFHQUc1Z3l2VTg2SnJqcTIyZXJJdjd2VHovQzRKZS9kcmJxMWdE?=
 =?utf-8?B?Rjc0ZjRqaTNPZFcyWEQ0SWJ3Uy8yZVZaRHBTNTNHTmREaWlNaEsyNm8vTmdK?=
 =?utf-8?B?TldlQkVWaG8vUHpKZUUwc05kaFpsTzFiaUhadDBZb1ZTMml3VjZ6ZHVaUXQz?=
 =?utf-8?B?d2hjam1jTW9zRXdIeTlMQ1lFSU41Ykd1L0VwOHFEQ0U0SG9LS2tacy9YQWg5?=
 =?utf-8?B?VXdTUUVra2lHaUJaOFRlMmRDNCtkVkU2N0N0TWZTZVoyNTZZVi96UDltM0Zx?=
 =?utf-8?B?NGYzUlkycjRWd1VxbUhuc3lscWZwRHlzZC9JQ2MvOUpUY0tYWDdKaDdxL2cr?=
 =?utf-8?B?a2NhTG11cURFS0wrN0ZWZUIwOGFXd1ppdTBGSGlPZm9ORytKSUVJdGd0bHdu?=
 =?utf-8?B?TGFkY1JMSzFidTJhc1g5T0NwVEhIdEd2VytmNVZXZXYyN2Q1Tng1NUlHendU?=
 =?utf-8?B?dE16dDJmRmNiUXBlREJ2VTEyNVRjYStIRkQvdFlFNE9uK1JxUGZGMlcxVEt3?=
 =?utf-8?B?b2VvQThqenJ0ejZIZ2Q3cUtLaWRkRzhvNTFVNWI2eVBYTUtNd0dZRVp6SzJv?=
 =?utf-8?B?ZS9ZeDJGWkxSd1FqTlNCUmFodnd4SndWTktVc0JYM1lMRERsMXJtM3JNTUhR?=
 =?utf-8?B?R3hZVkIydVdzT3JFWHJhV3hRU3B6dk5RWnJnMGJuRUJocDJuM2dTYloxakpQ?=
 =?utf-8?B?aDVmQ1pTMFBhbmZOYUFJZy9ZYmpDclEzbjU3U2ZTOG1GTFVramt3OG8wRFZ3?=
 =?utf-8?B?Nm42cnJYNGMxOU03RjRJR2o1V2xXVDlIQUdGR1dPNGFlVGhyR3I5Syszd3hC?=
 =?utf-8?B?SHBkRE5jZjNBa0xMa04ycFd5cGFwckZFekpnZTF5T3VBMUd3TldrSGZpVktS?=
 =?utf-8?B?YjJGQUdsNTIvTXNMYzdubHVhVExHaFVHSytBOFdIRXM1SFlvWjhGclo4bWFU?=
 =?utf-8?B?aS9Xa1hLR2NjTlB3bTNvMmNxVVhsNjRrNXBjL2EySXBYSnRJam85SnA5aEUx?=
 =?utf-8?B?dnlGTG9vK3RBNHJ5cnA0V0pEM1hEQUQ4MTFTdmFJM2Z4bCtodEQzNllhaTNK?=
 =?utf-8?B?dXdYMVh6VXRHRmVoUmh1OCsybW9kcW4wRnhKVjZyUkU1MnV4TVpIMEdtS3VX?=
 =?utf-8?B?VDJFN2NoTTYvdlpoNDBJR2hHeDBqTHVsREpKb3RXRmJMOEJHbjZieE40RG03?=
 =?utf-8?B?WEpZODZiTXVkNW9tM2JmZ01YRHVucGRXRktBT0ZVVFh5b2NVMG5kei9sV3FO?=
 =?utf-8?B?V0dNNGhxcjNFMHBMY3J4cm1DcjVlM25vSUd0bnpWK1E5clVBKzQyM2lmbG5z?=
 =?utf-8?B?cUd6SzVJK3dXTXZ6VEtST0VJUVdjcld3RFFLT0M2bEtHYWlML0pkWlVGWm1G?=
 =?utf-8?Q?Fpo7BCB/flARtvDjZNlOxcnY1EOLOA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SXhtQktGWG9HUmZ6b0JnQk1yNzlNYnBOSkpBd1dnd1VhZkpqQ081VG5iQTdx?=
 =?utf-8?B?WXhGelZza012TkNibzM3bm1LREVQTDZwTExGTWFkNHZaVEdLQS8yTWtQdE1T?=
 =?utf-8?B?NFRwZDdhMElhRWpGcU5PTFIzWmo1bitRQ1NsYXlzVmhSQTZ1VXl1TEhNajhX?=
 =?utf-8?B?N29PUkZ0aGE3bTNCemI3UmREMVNWOFhpWG0yR0lTWlFBanZHV1hsWGJsZ29z?=
 =?utf-8?B?QjRZNXBTcEhMS1R0U2J1TnZpdFkzeFhHOVdPN3c5ZVdOMzNSZytWQkJMYzF5?=
 =?utf-8?B?VjZObWN2aGh0czNlZ0tzaGhwSHBBczZSWloxaXJOQkZWL004WmVHajNOVGFB?=
 =?utf-8?B?Vy8rbElaR0lvUUlTWEs0YXFJV3hkL1JvSzJYTndqdnE3RnZVa0hlNHRYYi8y?=
 =?utf-8?B?emNhTDhBN0RBbENaTXdXclF0WXhTbzlQd3ZaT3p2akNTbGRRTUN1S0hvNWJT?=
 =?utf-8?B?T1FIckMzVFJYSGc1THB4UTBGYXRCd0FPczkwYTkvaVZiZFd6R1ZzaTB4TFR3?=
 =?utf-8?B?STBsbzJiR0VPT1FIaHZENkgzd3VCdUV5MzEycjBCSkhRL1E2eW90UHhydk5F?=
 =?utf-8?B?bUZRd1l5aVFnQVp2YjVkMWhoQ3ptelpjR09veGdwUWsyZ3FIV0RRMjRxdXFz?=
 =?utf-8?B?MkVDaXZ3eWM5VnFoWWt3N1lFVlZqdy84ZmprQ0FWOXlTaytxSHhXbG94Mkpu?=
 =?utf-8?B?TStabGFwa3FheFYrNzAvbDhoalE0RXFKR2JOa3F4MkRSbmlCWEtzZkVoUDVs?=
 =?utf-8?B?TDJzQWdTbE8zVG5ITVhpY0d1Y1R0dnppTkdiOHp3TTVxSDJmVzlFbnlTQ09s?=
 =?utf-8?B?Y1ZyVW9HZ1pieGQwNVFNVVhDeUcreUFpbldkN3NiYTFKQUZVSVUxRXZlcTU3?=
 =?utf-8?B?ZVMzSkZ5bkdybWdCRVA1NXNSN21XbGJrQlhtakZsd2I4SUs1MmZwMFhpc3Ey?=
 =?utf-8?B?RURsRTJ2WmxTYzV1RGVnSU5XV3hYSGtKVTBEbUp2OUxzOUxpS0J5M2ZHUXQv?=
 =?utf-8?B?UkZ4ZGh5MHRoTVZqNStiTERLZHdoT0R0YVZHVnFaRnVmUGtVakV4S2FuNzR6?=
 =?utf-8?B?NWYyQ2hMbERMYzNZdXIzMEdJc2tSdVlsWi9IK0VaVFF2RUtTQnZpSlNveGFJ?=
 =?utf-8?B?Wk1LUjJLS1Q2b2huak5YTGxEQldvQmIwdXFvUWhZYm95bkNzUlpVa1dpeXha?=
 =?utf-8?B?QmVpNndCWndrK3VNb3k3SzNodXZtZ1JkWlZUQ2gybUJMZ1I0Y1EraVh4SDZH?=
 =?utf-8?B?eWx3ek03N0sxMGZTMXZObFhSRGIxeWxaSFF1RFo5QmpTNjFjSHNicnJXb2xM?=
 =?utf-8?B?bWJXZmR0UXB3Z2d0RjUwNW0xREVXTktTQklNTXJ0SEJ5TzAzSEZkUzFUMU9C?=
 =?utf-8?B?dmt4d05MSStub0YxeS90cmxQTjZhY2swT1kvUWRyc3p4UnFsSzBwaUtsc2pU?=
 =?utf-8?B?bHAraEc2ZHZ5ck1sQVpwYWx4WElqcERwaXBSbXJFamdrVm9nN3FEV0kyU3p3?=
 =?utf-8?B?Y245cGUzWnc3cTNDZjBBVGtoZjAvaVMvNnVtMEY1bTNQem14S1dQZzhjaHdQ?=
 =?utf-8?B?YnFwbFM5bENDRzdJZGR1aXRUSG5CRDFNbHZmbU15d213d1BicmtVU3kwM2w4?=
 =?utf-8?B?OTdUZXhMRHBGKyswMnQ1NVYzbk9BTElqZTRMR1o1WGZPVVRhTFVyM09OOHIw?=
 =?utf-8?B?dWMvZnlzVDR6NFc5QXdydnRYTGdrVUxqNU5aZFdYZlJSMHh4NGJrek4vSlR0?=
 =?utf-8?B?eUpIYVJZdlU4QzlwOE11cE5ydGNlcTNuY2VETFJTYXFFV0cxMzVrN1FyVWd2?=
 =?utf-8?B?TnRVaEJBa0ZNUVIxbXJmbCtqTndGVmNraDF4aUhmMDNpRjEwREFXMFgxckZr?=
 =?utf-8?B?OGRjMlZHZkxaN0tQZ2RLVVEzWS9kSGkzRVRTajRlQ2RTcVk2RlFkVWx4Skto?=
 =?utf-8?B?a1dPOHUvbFdiNWtpdFUwWWxoRDh3ejlmZ2xMdlRQd1JrUUJNNnZmZmIxTE5y?=
 =?utf-8?B?NFBJNzFhamt6TUF3TjR1UVJUR1BJOFo2YzZFbVU3U2tQNGJxNXRRM3RUSjFk?=
 =?utf-8?B?NjJVRDJEWEJpaGdGa2FkWTNsT3dLN0t6QW9BczlvbjExWUVWSDM5VVNyTW8z?=
 =?utf-8?Q?Mhlk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91241a2-f35c-4de2-9634-08dd8c446517
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 02:19:13.7872 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIRUQMh2pbR78aFjolsH90qMPEYHrfLmkjdRS62dVelO7D3okMpc/g6jxvyLTbDm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6955
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W1B1YmxpY10NCg0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0Bh
bWQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDMwLCAyMDI1IDc6NTggUE0NCj4gVG86
IExpYW5nLCBQcmlrZSA8UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnDQo+IENjOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFt
ZC5jb20+OyBLb2VuaWcsIENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDMvNV0gZHJtL2FtZGdwdTogZml4IHRoZSBldmljdGlv
biBmZW5jZSBkZXJlZmVyZW5jZQ0KPg0KPiBPbiA0LzMwLzI1IDA0OjQwLCBQcmlrZSBMaWFuZyB3
cm90ZToNCj4gPiBUaGUgZG1hX3Jlc3ZfYWRkX2ZlbmNlKCkgYWxyZWFkeSByZWZlcnMgdG8gdGhl
IGFkZGVkIGZlbmNlLg0KPiA+IFNvIHdoZW4gYXR0YWNoaW5nIHRoZSBldmNpdG9uIGZlbmNlIHRv
IHRoZSBnZW0gYm8sIGl0IG5lZWRuJ3QgcmVmZXIgdG8NCj4gPiBpdCBhbnltb3JlLg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogUHJpa2UgTGlhbmcgPFByaWtlLkxpYW5nQGFtZC5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4N
Cj4NCj4gVGhpcyBpcyBhIGJ1ZyBmaXggYW5kIGFzIHN1Y2ggc2hvdWxkIGFsd2F5cyBjb21lIGFz
IGZpcnN0IHBhdGNoIGluIGEgc2VyaWVzLg0KPg0KPiBQbGVhc2UgbWFrZSBzdXJlIHRvIGNvbW1p
dCB0aGlzIG9uZSB0byBhbWQtc3RhZ2luZy1kcm0tbmV4dCBBU0FQLg0KDQpUaGFuayB5b3UgZm9y
IHRoZSByZW1pbmRlci4gIFRoZSBldmljdGlvbiBmZW5jZSByZWxlYXNlIHRvdGFsIGZpeGVzIG5l
ZWQgdG8gaW5jbHVkZSB0aGUgcGF0Y2gjMSwgYnV0IHRoaXMgZml4IGNhbiBiZSBwdXNoZWQgc2Vw
YXJhdGVseS4gSSBoYXZlIHB1c2hlZCBpdCBub3cuDQoNCj4gUmVnYXJkcywNCj4gQ2hyaXN0aWFu
Lg0KPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZp
Y3Rpb25fZmVuY2UuYyB8IDcgKystLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfZXZpY3Rpb25fZmVuY2UuYw0KPiA+IGluZGV4IDZjOWIy
YjQzYTkyOS4uN2E1ZjAyZWY0NWE3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9ldmljdGlvbl9mZW5jZS5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlLmMNCj4gPiBAQCAtMTg5LDcgKzE4
OSw2IEBAIHZvaWQgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2Rlc3Ryb3koc3RydWN0DQo+ID4gYW1k
Z3B1X2V2aWN0aW9uX2ZlbmNlX21nciAqZXZmX21ncikgIGludA0KPiBhbWRncHVfZXZpY3Rpb25f
ZmVuY2VfYXR0YWNoKHN0cnVjdCBhbWRncHVfZXZpY3Rpb25fZmVuY2VfbWdyICpldmZfbWdyLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGFtZGdwdV9ibyAqYm8pDQo+
ID4gIHsNCj4gPiAtICAgc3RydWN0IGRtYV9mZW5jZSAqZWY7DQo+ID4gICAgIHN0cnVjdCBhbWRn
cHVfZXZpY3Rpb25fZmVuY2UgKmV2X2ZlbmNlOw0KPiA+ICAgICBzdHJ1Y3QgZG1hX3Jlc3YgKnJl
c3YgPSBiby0+dGJvLmJhc2UucmVzdjsNCj4gPiAgICAgaW50IHJldDsNCj4gPiBAQCAtMjA1LDEw
ICsyMDQsOCBAQCBpbnQgYW1kZ3B1X2V2aWN0aW9uX2ZlbmNlX2F0dGFjaChzdHJ1Y3QNCj4gPiBh
bWRncHVfZXZpY3Rpb25fZmVuY2VfbWdyICpldmZfbWdyLA0KPiA+DQo+ID4gICAgIHNwaW5fbG9j
aygmZXZmX21nci0+ZXZfZmVuY2VfbG9jayk7DQo+ID4gICAgIGV2X2ZlbmNlID0gZXZmX21nci0+
ZXZfZmVuY2U7DQo+ID4gLSAgIGlmIChldl9mZW5jZSkgew0KPiA+IC0gICAgICAgICAgIGVmID0g
ZG1hX2ZlbmNlX2dldCgmZXZfZmVuY2UtPmJhc2UpOw0KPiA+IC0gICAgICAgICAgIGRtYV9yZXN2
X2FkZF9mZW5jZShyZXN2LCBlZiwgRE1BX1JFU1ZfVVNBR0VfQk9PS0tFRVApOw0KPiA+IC0gICB9
DQo+ID4gKyAgIGlmIChldl9mZW5jZSkNCj4gPiArICAgICAgICAgICBkbWFfcmVzdl9hZGRfZmVu
Y2UocmVzdiwgJmV2X2ZlbmNlLT5iYXNlLA0KPiBETUFfUkVTVl9VU0FHRV9CT09LS0VFUCk7DQo+
ID4gICAgIHNwaW5fdW5sb2NrKCZldmZfbWdyLT5ldl9mZW5jZV9sb2NrKTsNCj4gPg0KPiA+ICAg
ICByZXR1cm4gMDsNCg0K

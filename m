Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A19D10DB4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2024 08:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B7110E48A;
	Mon,  2 Dec 2024 08:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k/nlz2OC";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A13A110E48A
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2024 08:15:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDzs0F+YgM3BZgQcHg1uSswCjjoGu3DFh5cT0YBNAD931A4DcYPt0XU9y8lZXH59oAmcvh1nHaCRsxszABWKcmM/9wXzlBjrmIgztaMhrHofycTZODc6gHO+um8VB9qq1XcVuMpLspUiQpCBkWzElKlx01ud61Ae/iugOX2UqZp13VL3XhO/8rBa8mC7oNavdZa/J9u0BlCrvV6XGWHd8D5ZTR0dwPkaxCurohFZOTrJQVxFTUKytq3qZ1/W3e3AelpKokjmi6GOPl8Tz8EqhPMEGd8/hY2pPiH2DX/SWjfAUjoCG1yyUmru3R8cus6gLOmsmwPoh8r0C8iLuxCNSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtQAc0DRodg1fZVfM3uGSFdT9+w7kgSU2wygzhOztzU=;
 b=ZPMKauqYSfds8sWkYeyOgnUMQIFHgU6TgVkOMVgnUAqdBQVBRIl50q/1b550fXZuYqvEhUCNmhNUNa9kNUhnE+OEat8XKo8xn17dPQH+4GE6vWb2cx6YoI3j6EVktbTwAyqRMyT3BI0OGwOk94Qiqg6lniDl7VOZegVo34ePs+MRPPAr5dbCJx4NTDAoM1ss3IKoR1yl6hOT65GMCKdL9b4z4TBMD8shssdmL3P2yr+g6XiFOzBTlDV/VefHoOaKqUwPkcVMY67hiuv+hxTIExmF24jgsqJH6kGpjZ4Tb6YWx0gY5XEEpGSNz9oOcCiZhQ/OOPnA01Ie4gwnsI/mKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtQAc0DRodg1fZVfM3uGSFdT9+w7kgSU2wygzhOztzU=;
 b=k/nlz2OCjFM5H373wMtMRhIEbkXgPKFd8zMyfz91hLgLId9UsyyZ88YjCZKTiThfNST81bnwUpYzDtUdDK8NzBPfarxl01nk4ayjVkxoTxDoHFjPnMmNtZX5BlyiswqMb7GZXfvOaSBIgy8LYMtLIDtLzXKg+ZxuyzxWW2eLnbI=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 CH0PR12MB8464.namprd12.prod.outlook.com (2603:10b6:610:184::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 08:15:31 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::4dc0:f34c:9e7e:ccb%5]) with mapi id 15.20.8207.014; Mon, 2 Dec 2024
 08:15:31 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Avoid to release the FW twice in the
 validated error
Thread-Topic: [PATCH] drm/amdgpu: Avoid to release the FW twice in the
 validated error
Thread-Index: AQHbRIXq0zPHIy3wE0mZpoNhBLdma7LSk4KAgAAHlbA=
Date: Mon, 2 Dec 2024 08:15:31 +0000
Message-ID: <DS7PR12MB6005EA631B644E5764AB1536FB352@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20241202064615.516559-1-Prike.Liang@amd.com>
 <fe3187a8-666a-4842-9aac-032462de4a1e@amd.com>
In-Reply-To: <fe3187a8-666a-4842-9aac-032462de4a1e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=aaf0eb16-5578-444b-b3d1-2ee1bcd9b592;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-12-02T08:13:29Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|CH0PR12MB8464:EE_
x-ms-office365-filtering-correlation-id: 0516f662-a87c-42d5-3608-08dd12a97ce4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cE1OVlNIWlhKaUFlVmxHUUlBb3BMSzBrd2o1QnErTUZwbzBROFFINjRKcGNG?=
 =?utf-8?B?SWxxT2NoN2h3ZkJDamhaUk9rUlFvM1ZOZXkxTlQ0Q00zcHBuOXJ0NHkyWVdj?=
 =?utf-8?B?VmJncnIwemlIY0dwZFIxRjJLdG13MkRXVDJ0aVZHV2l1SVpJUjVubUwrMW5C?=
 =?utf-8?B?dHhsOFhDS2NoR3pQVmN1NjVYRnFkaGVCQytKbG93cm9ucDhYWnNWK09LRnhw?=
 =?utf-8?B?c2lnTERqRGw1TWRkSVA0dDdrdEcrenJQT0pyZ0FYS2MzemJUWjUwLzNTT1VZ?=
 =?utf-8?B?R0h6VHoxeElydFpHZElHVUVMc3NmRWQ3R203Q3hmYTJVUk56RlZ3ZjFGUEZs?=
 =?utf-8?B?VjkyL1BSSlU0VE5mL2VHK1E4cG1OaDd2dkYwWmhGQjVZNzF4NlJQTzZpakRB?=
 =?utf-8?B?djNCbVpiZ2ZIZjBzWVRKdmsvUUdYaGc0MFliSTBUOXdrNUdYK21qM2o3S01o?=
 =?utf-8?B?VDYxbU4weW9KNm5xcW1OM3UvNi9RZHV6WG56RkFhWjBLVmVZY3Zsa051MCtQ?=
 =?utf-8?B?RTVjZ1Y3bW1aZk5FdXMvNVFudTYxZCtVd0tXYUNva0VwU0ZmdnluNFg5Qkw0?=
 =?utf-8?B?b2N6bEFZMGlUcWVlc1dFSzhRYTVkWmZrMmxZZWhpc3JwbkJ4N0JPM21LVzAx?=
 =?utf-8?B?ODh0a24xODdRQlk3T28wczZmSWJYNmR3UVpvVjhUMmJQYVpjanhienU1aFdl?=
 =?utf-8?B?YmM2N0RuM0V3bjI5ZU5uQzlZKzB2NTlKUXAvRDFSM0t1c0FCeEt0MWlKQ25X?=
 =?utf-8?B?MjNnMUpXcG9hcFYvSTVJTWhUa3RkZS9hbWlZdFZkcGZFWjJZRVQxQ1JyK1hD?=
 =?utf-8?B?ZEJyQ2JJVlMxNWdGYkdKR2Q1bWRrSHAvUnoxMWxEeHBIdmh4dS81cTFPbVUz?=
 =?utf-8?B?MWt5N1dOQzBYb1NkNGJyb2g0cW1oUW0vVExjd1ROTSttTTBQZXVjQnRyaEhG?=
 =?utf-8?B?N2J2WTJzamJaeExVRDZBaURCcEE0WWNTR0gxU21HcTNZU1lGcHlTTGVna0hH?=
 =?utf-8?B?d3E5VUJxQ1BVWGdLdlJFZHMvVlUvUzBzazB0U3g4Umt0UUZGTXFINm9HT2g0?=
 =?utf-8?B?VERaOVhCRXJzME1neWNFWFBoSU1kNmJvSjVGSU9ucFB5L1YrQm5WSnd2R2ZT?=
 =?utf-8?B?TzBpK0lydTMzOWdjcVlIaFRVRzk4d1BkUjlLNGRCRHhrSmFuNXVxWUNnYmgz?=
 =?utf-8?B?a21XZEhQTFNna3dyaWJ2ZDFPZEQ2U3lRZW43TEJiVVZaVzU0WTlnMnFUWjJ3?=
 =?utf-8?B?bkNwT3d0bGlsZU9Da1BSc255NTh1NjZabmpLUWEvem1TRnc1b0poK0MvbVpM?=
 =?utf-8?B?MGFxOEI1cnFjVUsvUEVKZVMvODlEdVdMVmxPSFc3R3NWdWZJTHl3djZtWDZ2?=
 =?utf-8?B?Mm1ycmdiYWhzSDZhTWpjYjdDaW9KRWxnaHFKOWxvR1dkYWEyVE9kUWErSVFq?=
 =?utf-8?B?bjFJaGRPNlBDNDNUbjZXZFU4cmdVTCtKZ0lwT2NkcUdnd0ZFUnVkbEl5S2pO?=
 =?utf-8?B?TFNrS2YvaEs2RG5LTisrVUZkRFk3dUQrZi9NYnkvYy96djVIWWo5Mjc5OU00?=
 =?utf-8?B?YzM1ZkpER0N0YVF2NzhLR2dXdVl0aDB5WnBQdVdDS2xzVlVjQUtjSW9tMlZl?=
 =?utf-8?B?R0ZNY3ZjeFlvNGQySGRRVGhEcDNabk9oY0lrSHgzMkQ5blozZk9mblAwdXlj?=
 =?utf-8?B?b3ZnQUtwYXpFYmlYRG1LTFNIQVpZUmpmTU4vNlZoTEFOUFBjZ2h4N1YwSEw4?=
 =?utf-8?B?OU9mNnd1OVJMY21SOXExME9hRElrdUlzUjdIOFZ0cnpKOTJxVmg5YlZscVVU?=
 =?utf-8?B?eGdaTkdnZU4wZnAydnpiYmxkY29Xc3c2WHpkTmJ0UWZ0ODg1dGhNWW1jby9r?=
 =?utf-8?B?MHNuMHczRjJwQ0xhZi9paFozRTUrOXhFNS9ESU5JVkhXbnc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OGpnbFJHdzBRZXUzWUpnaTRicXViY0pNMUNmaUZldDhwcUEzYS9PSisxVUdt?=
 =?utf-8?B?R1RtSnJzc2ZuT1p6L3BsREZGbVR2MTNvWEgxdnZiQ0hkTWd6RVNCY3F2RE1N?=
 =?utf-8?B?NGpmZTQ0NEEvZ21lV0ZLOGRtV1h1VkRlUStSRlhWSkNudVg0R3pVUHNYaXdx?=
 =?utf-8?B?N2paWmVobGptTlNMc0Q1NEhJRjc2S3dLNzI2dkdlNkVuTnU5b2VXSnZCeS9G?=
 =?utf-8?B?MUtqakZKdHcwNDFwTDZZRFF0ZG52cTByWXpVK3NldUlQQjhCc0NjamxYN2du?=
 =?utf-8?B?c1VESG5FN3cya1N4QktESWpiRzduVFAyOXZFbGtkVmFEdGRJYWFya2NkRXlt?=
 =?utf-8?B?bHlnbDV5RStqZGhtNGFzN0hYSGFxb1ZZSWJNT2xCODhTNGR2SjE1dHZ4RkZ6?=
 =?utf-8?B?YUdIRXAxOXJWamk0N2haMldkSExZUjRvbzJGTDJWb2kvblg1TDFJaTV6OVFZ?=
 =?utf-8?B?dmtMV0Ivbmlmd1QvdU91bVI4d1ZERmYxNEQ1TGRaQjZpY2F5bTlROEZSd2h0?=
 =?utf-8?B?YytnZytNdS9iclFNN0c2VW4wZ1FTMXNIM0dtRkZaKys0bmxkK3E2Uk5MZXNQ?=
 =?utf-8?B?SjA2T3lBbm9Kb2x1cnQyTXJMMzRxcGVITjU0WXd5cHdldzVVV1V5WWtLYVZ0?=
 =?utf-8?B?bkFRTVNxYVM3ZkF3NEl5MHlLckZMOEFtREMvTEpQWW1Zb09vRFF1UXk3TGo5?=
 =?utf-8?B?TE1kQ2ZZMkVXVnRSYVFiR3BXNEhOcUxUcXpvcUNxaGlydlNWZVVPRzN6V2hk?=
 =?utf-8?B?TlRYbXllMWJyczUyei9ocG1qZi9MVWFVb0lBQmcwSitQTUxvWG55VEZhbGV1?=
 =?utf-8?B?L09xQ1k4NW5uOVFMeEtMbDFNYnpxQWMwVkJ0U1Jva1EzUzZybGJCYnR4T2xw?=
 =?utf-8?B?MXV2WnZKOGVQaTVIUWs1UXZ1UjFaZXl0SGNGRXBieU5LSGMxUGtjU3ZoR21j?=
 =?utf-8?B?Qm9CK2oxVnhyWTBnaGdLaVcrbjJ5K3VxczlDTno0TmgrZzNBeGJWRSs2cmN0?=
 =?utf-8?B?M0pVWm5ydGdTcEJ6SkFtcWZSblRJOU5JcEswYVU5MTNCQXphMnpZUWFwclFL?=
 =?utf-8?B?M3RTMkNSUUQvcWtKWUVZWCtaMEtFU1l1ajJMZHZHMGVlZHVQYXRySktrbWRh?=
 =?utf-8?B?ei9yajRNei9ESzZaU1BWazZ3c2oycDBvOGVPWVpIZ2pnOEZidGlob1hjLzZi?=
 =?utf-8?B?clNSTDZZUnlsNzZTVUhvNVZ3cjJ6OFN4VVdUTFVWU0IvNFBycUZQanVaeFBr?=
 =?utf-8?B?NVpsU1hLdnJocUhGZFdXeU1kTUFvOW5aMHZ5OEppOHR2VXJzS3crR0dseFQ1?=
 =?utf-8?B?THBWRm9vMGpvaWtSTVFDSlJoVHJOUVpTc0NQT0lYUDJGV2lzdXAvQU9jbWhy?=
 =?utf-8?B?bEhIU2o4a2VEZlMwdUJJM0pHQWpWYzhSVjJhWkFCOGE3T3BLcXp3Y1JWeXlJ?=
 =?utf-8?B?eDFJbmRZcnVWVUdRdndMQVhtZnZOcDFDeWRSZTZZRTFqYW1pR2hoVlBMaUh6?=
 =?utf-8?B?SHJGNXkyZ2E4SlpiUHRVRjJWZm9GY2x3cTVkdXErSzdSK2N4enpESzhhbGRm?=
 =?utf-8?B?cEUwZVdZM3N2SUNZMzczeWVDWkpvcmJGQ2Q0RGNSdGVRQXJPZ0pTeDJYVWpE?=
 =?utf-8?B?c0wvS1p2QXIraTE2cTY4T01NS3cxVVE2WjNSSk5XZFVjQzlVNC9ZbGQzSzBK?=
 =?utf-8?B?QnE0QW94cjljY3c4bUN1S1FRSjVTN2NWWkJuYVczemVEYVhzY0RNYWRqYW1l?=
 =?utf-8?B?Y3ZSczBpNExRWGMwdFhtZHdEUVZONkhqb0w0Z0ptNmhnK0ptRmFlZ294T0xK?=
 =?utf-8?B?Sk1BYnFGSUdJK2ZXMFVOL1d6dDMwQjYrR3pVTmVDWEhYS3l3a2FnYUxKY3FZ?=
 =?utf-8?B?Nyt1bVgwSGl2emcxTkdrbU9qVDRKSXZzdjBreXV4OUZnbG5yZDFjVjcxY2pU?=
 =?utf-8?B?RExHU0dtQnA4aFpDaUIzYWpNWGVPR1YwTm9mRmhkSTBqRjFlVW9uUW9wZ1V6?=
 =?utf-8?B?dFZYNGQzeUlFMjgzdjF5UmpWdysvTnRVSWVwY1R6aFcwVzhpYlEwYU1jeEpX?=
 =?utf-8?B?cERKV0NIK0pwQVEzRDB4QVV2dzh6eU5ETDVnV2lYYXJiSGxWNFBBRU12WGhX?=
 =?utf-8?Q?2Pjg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0516f662-a87c-42d5-3608-08dd12a97ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 08:15:31.0281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hDAhSIWGw6O/76I7rMqw+fzddJdOe6+58GHZhQ5VUtsYZuYEzCRHgsj+PtSsYtHb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8464
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KVGhhbmtzIGZvciB0aGUgaW5wdXQsIGFzIG9mZmxpbmUgc3luY2luZyB3aWxsIGFkZCB0aGlz
IHJlbWFyayBpbiB0aGUgZnVuY3Rpb24gYW1kZ3B1X3Vjb2RlX3JlcXVlc3QoKSBkZXNjcmlwdGlv
biBwYXJ0Lg0KDQpSZWdhcmRzLA0KICAgICAgIFByaWtlDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogTGF6YXIsIExpam8gPExpam8uTGF6YXJAYW1kLmNvbT4NCj4gU2Vu
dDogTW9uZGF5LCBEZWNlbWJlciAyLCAyMDI0IDM6NDYgUE0NCj4gVG86IExpYW5nLCBQcmlrZSA8
UHJpa2UuTGlhbmdAYW1kLmNvbT47IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnDQo+IENj
OiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLb2VuaWcs
IENocmlzdGlhbg0KPiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIXSBkcm0vYW1kZ3B1OiBBdm9pZCB0byByZWxlYXNlIHRoZSBGVyB0d2ljZSBpbiB0aGUg
dmFsaWRhdGVkDQo+IGVycm9yDQo+DQo+DQo+DQo+IE9uIDEyLzIvMjAyNCAxMjoxNiBQTSwgUHJp
a2UgTGlhbmcgd3JvdGU6DQo+ID4gVGhlcmUgd2lsbCB0byByZWxlYXNlIHRoZSBGVyB0d2ljZSB3
aGVuIHRoZSBGVyB2YWxpZGF0ZWQgZXJyb3IuDQo+ID4gRXZlbiBpZiB0aGUgcmVsZWFzZV9maXJt
d2FyZSgpIHdpbGwgZnVydGhlciB2YWxpZGF0ZSB0aGUgRlcgd2hldGhlciBpcw0KPiA+IGVtcHR5
LCBidXQgdGhhdCB3aWxsIGJlIHJlZHVuZGFudCBhbmQgaW5lZmZpY2llbnQuDQo+DQo+IEJldHRl
ciB0byBhZGQgYSByZW1hcmsgdGhhdCBhbWRncHVfdWNvZGVfcmVxdWVzdCBzaG91bGQgYmUgcGFp
cmVkIHdpdGgNCj4gYW1kZ3B1X3Vjb2RlX3JlbGVhc2UgcmVnYXJkbGVzcyBvZiBzdWNjZXNzL2Zh
aWx1cmUuIGFtZGdwdV91Y29kZV9yZWxlYXNlDQo+IHRha2VzIGNhcmUgb2YgZmlybXdhcmUgcmVs
ZWFzZSwgYXZvaWRpbmcgcmVkdW5kYW50IG9wZXJhdGlvbiBoZXJlLg0KPg0KPiAgICAgICBSZXZp
ZXdlZC1ieTogTGlqbyBMYXphciA8bGlqby5sYXphckBhbWQuY29tPg0KPg0KPiBUaGFua3MsDQo+
IExpam8NCj4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFByaWtlIExpYW5nIDxQcmlrZS5MaWFu
Z0BhbWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfdWNvZGUuYyB8IDUgKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5jDQo+ID4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdw
dS9hbWRncHVfdWNvZGUuYw0KPiA+IGluZGV4IDRjN2I1MzY0OGE1MC4uZTdmNTA0MTU5MjZjIDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5j
DQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Vjb2RlLmMNCj4g
PiBAQCAtMTQ2MSwxMSArMTQ2MSw4IEBAIGludCBhbWRncHVfdWNvZGVfcmVxdWVzdChzdHJ1Y3Qg
YW1kZ3B1X2RldmljZQ0KPiAqYWRldiwgY29uc3Qgc3RydWN0IGZpcm13YXJlICoqZncsDQo+ID4g
ICAgICAgICAgICAgcmV0dXJuIC1FTk9ERVY7DQo+ID4NCj4gPiAgICAgciA9IGFtZGdwdV91Y29k
ZV92YWxpZGF0ZSgqZncpOw0KPiA+IC0gICBpZiAocikgew0KPiA+ICsgICBpZiAocikNCj4gPiAg
ICAgICAgICAgICBkZXZfZGJnKGFkZXYtPmRldiwgIlwiJXNcIiBmYWlsZWQgdG8gdmFsaWRhdGVc
biIsIGZuYW1lKTsNCj4gPiAtICAgICAgICAgICByZWxlYXNlX2Zpcm13YXJlKCpmdyk7DQo+ID4g
LSAgICAgICAgICAgKmZ3ID0gTlVMTDsNCj4gPiAtICAgfQ0KPiA+DQo+ID4gICAgIHJldHVybiBy
Ow0KPiA+ICB9DQoNCg==

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D85D42BBE
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 18:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED8A410E1EF;
	Tue, 12 Nov 2024 18:17:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PjTsgJmm";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3766410E1EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 18:17:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYu+gbn1YBlsUFdFiH1v/OV7qV0U8rmkYH7A2C+d2Lw8g6elSuyLgIZD/I+CcPLQ0iP30NJEzm69wt/TeZUwynBZXZ/COTM4Cqs9+iouufeq8MUoh7dvDPxXdPMfM48j/JDCN2UbZjfo/OFCFCqq4lUwmQjEvG5JqjO9QqbXrAC3g2pBi1O6BoP6HqV8vzmgdT5rAKZudsOLJJZXyCbC/ZUl4TAwA5AN44tPbQLcYcXMNYnBnSKAmItq866pz9Zx1wxj9J9FESWvi9FeCpSSkNGHKlI0p0XGMumHeMqvSQEpJI1qcLh4e/gGDq4eoovNUhqeU/eVFxkN+x9nEYZLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2XLFq3QzVwOitGC46gf86QEufMVFog8zMwAH2Ynt0o=;
 b=g3GkEcJ0n7JC37YOgNdPKfab4Z94gAthb3WQyfYcjZEtn+lclY4HxkCpk3hBmvjOkMG59r6fZ79NgjfzR5ZcZaEl8nRIEEjk/v8PPnY/EwrdgAAEtA6mzuFbcmmsYNHdfvzscG9acRIzPWCDNQCUtgJHnNdYlDgCXJX2VSiiDm2RoW/cTQlSJeE8FOc326ZS6DlqJAoHPurv5IMC1EVpEWbZ4joPkxF70sN8kDw70eYm7wtJmZy9MIbN2F0FXsEDbCSywcP7YZvTyAt6EKZxOEAB8Z9b/9+Ic5miuh+06uGu3KQDPzqSPPSuoHI+gOZpk543PKg7Z0a/LsbPXKbRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2XLFq3QzVwOitGC46gf86QEufMVFog8zMwAH2Ynt0o=;
 b=PjTsgJmm7ufsH/LoIJasjlOtgOnZCLx71Pp7ciROf+tokaDgUkzwZXByZY+jamWaXxtcTt84feVyZm2N2NYP4RXs9yB7NhGu4noQ59TmiNcqroNd6y0eU80i3hJtrB4ZxGCpMp7Op6BFYbn9gYfQ889fAxGHKnub9GiMBC1VCRw=
Received: from SA1PR12MB8599.namprd12.prod.outlook.com (2603:10b6:806:254::7)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 18:16:56 +0000
Received: from SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b]) by SA1PR12MB8599.namprd12.prod.outlook.com
 ([fe80::25da:4b98:9743:616b%5]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 18:16:56 +0000
From: "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "tvrtko.ursulin@igalia.com"
 <tvrtko.ursulin@igalia.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Topic: [PATCH v7 4/4] drm/amdgpu: track bo memory stats at runtime
Thread-Index: AQHbM4cm2Qy9C3gimkGj8UdltocsKLKze08AgABz2+A=
Date: Tue, 12 Nov 2024 18:16:56 +0000
Message-ID: <SA1PR12MB85998D24DDB5EB93AE88E5A1ED592@SA1PR12MB8599.namprd12.prod.outlook.com>
References: <20241110154152.592-1-Yunxiang.Li@amd.com>
 <20241110154152.592-5-Yunxiang.Li@amd.com>
 <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
In-Reply-To: <5d1c88a5-9802-4bb7-b76a-5e501847ced1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=00ce8390-99ab-4130-b8c5-cc4bc4ee26ae;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-12T17:48:49Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8599:EE_|DM6PR12MB4403:EE_
x-ms-office365-filtering-correlation-id: 49a66033-6f97-4696-dbbd-08dd0346313a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dmFacG5abWhDeGc4cGZGekNMemtZcXExWldhY1EyZ2dGY1JMZUZNZVczc3Ry?=
 =?utf-8?B?RFlrOWN5OFVrN293UDBJRzRZM3R2NEdqYS9pYk9jOHh5SjhGS3FlL04wc3Bn?=
 =?utf-8?B?NHd3UCtIclNNakw4TEVDYXZRSEVZTjNLVGxkMTF5eHZ0eTBPd05ha3VMMUx4?=
 =?utf-8?B?Q2NIemxZWVlnWG1wR1dmOWlmVG1mRzNPay85NmhJbGdjNG5rOUVKdTd3WEJq?=
 =?utf-8?B?K250ZzdrQ0NWaHN3c1ZabHY5Y20rcFR6TkpOVk53TVlFa2tRaVpIdWRWcDNM?=
 =?utf-8?B?ZDduWGY1d3lWdUhvTFMxS3dsaE00aXJPS2N4VnpFSzNqdTQ3NUlCUnErSVBr?=
 =?utf-8?B?eWw2SDVKUHc4SWd5Z0QwWWFwME1FS0hsSyszMndFUm4xZXVnYkwwVDZvVVZI?=
 =?utf-8?B?alN5TzY3bWxDazIwZnA3dWpyRjJEOWJreGFaY2M4ODlLZGtsK0dwRmt2MHRJ?=
 =?utf-8?B?b1R0d2FoMFhDY0VrMDRVUFY5UmtKbGtzQ2o4Mm1CTTB6WUNEckZ3NXR2UGYy?=
 =?utf-8?B?RXRON3RMVlNzZzJNc1ZNMVBnQ2ltOTBUckJIaFRtb0ZMSk9SQ1FGQlVuS3BM?=
 =?utf-8?B?NC84NVgrWmc0ZDQwYTRPWmhrZzZydnc4Q0xid0Z2Y2RnWVlOODhXV0w0Z3RF?=
 =?utf-8?B?UGdwemZoSGRwUmhIYzBvVks5QVo3ZXJOckZDQkk4RFJxRnNaWFJlTVZ1ZHlJ?=
 =?utf-8?B?NDRKTzBtaHREazNYK0NOMFAxemg0WHJuMjN4VndmMlZlTzlwbFlZTXpvZEdo?=
 =?utf-8?B?Z2JVYXlOSWtzakpnOUR0cVkycURPUi9xNGxZakFodnU0Q1hjTU1aWWhYQXpp?=
 =?utf-8?B?OEZhT3F6bU44R25hWFdIZlV2c2poQ01RZ054aUhyMXF5a0Jtc2lSWTFOdjd5?=
 =?utf-8?B?TVZscy9NbVJhK0J1aGNmRzJ1ZGVBeUlGcmM3bjU1R0RWb05JS2tRQm1UV2hm?=
 =?utf-8?B?N1IyQ0gvUWdROVhpV0FIeFA3ZDVLczd0dWJ2OUtjd0loRnd5Umx0My9RdjVX?=
 =?utf-8?B?Zk5xdGJpbGMwMHhnZU5rdUZPZ0RqU2hlWDIwNitEa1F1a3BLVno1NTRrMWYz?=
 =?utf-8?B?djFlQitucmszMm96dDkybi8zS1VicU4zdGFuRloxS1Qya2RGVS96MTI3b2pZ?=
 =?utf-8?B?QjV0bjUwSEZzUHNQMm1yWVZGYjlFbHpJWVRJUlE4WUtid0NPbDZlYzRQNHA0?=
 =?utf-8?B?MDRxS3hVbnN5TUpBc1lvb3V2eGdITHFpcDhuQ0VJcjE4NUl1bGpWdWQ3d3p1?=
 =?utf-8?B?ekw5aDJvRTZvY0JJTVlYaGF4KzJhV2szVnIxU2pxcm9WdWpJd0R0Rmp3VUVu?=
 =?utf-8?B?VXRvWXhpeVZ1dmRuSlhCS1JzN1lvOXc0VEFvOVVydWRia25OeU5YQU9jbmdz?=
 =?utf-8?B?TktEWU5BcXloL2RFWlp4YWJQaytYSTEzUm9zcS9sK3BldjA0QmZxODNKN2w2?=
 =?utf-8?B?NENqeUlNZ3RDRElxV0JxY3pNQ2F3WU9oRkdzbW55UFZ3eXhSdTB2WGRKRXR0?=
 =?utf-8?B?VTVHeWUzWWd3ZzBKam44VTNqd1hLVnNaS3pqa20xQU5OS2RDZWRuWWMwaHEy?=
 =?utf-8?B?dFUwbEszSmZOSStEaEZXZFJJaDZ0S0JWZUNNNjF4V1E0eXdlN2pROWc1azVk?=
 =?utf-8?B?NmF4UGJpQ3QyUnBRRENMRUNGR3c2ZWxOUUg1Y1laRURkcU5iSmtCdTJnRG0x?=
 =?utf-8?B?WXMwWjVuUzZmbEx4VXZDYXJ0YXkrYjVhTWUza2Z3dTVVQjMvMm5SMU40V2tT?=
 =?utf-8?B?b1owSlh2N05jd0FUdTNiYyt6N0VXZDlwbFVwLzgza3RNdnIvWG5HNUVGMWRw?=
 =?utf-8?Q?qcO0OThtYpXIwlAfQNOxH648y8weMJWab/Ics=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8599.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmpJV3ZKNkYxZFBRdUZmREtCWTVwdXQ5VmVHeGc3UVgzUmxhaHFHK3hRWVll?=
 =?utf-8?B?Rk85QzAzUnNjWnROZkFIMUl1cHpCRjBMMTVraDN5Y2lqOUZ6ZUhmWXVMd2lY?=
 =?utf-8?B?YThUWUIrckloSFpWczdpT1dxUVN2ZWsrUDhMR3FjRHdpQlRwT0NMaWc4dllT?=
 =?utf-8?B?T042V0txYUJoclhudmZ1VHN3T3l0VWd2b283emVNSVUwUWdkekV3Qlo3cElO?=
 =?utf-8?B?VUlJMjI5YVVKWlNkTWo4QjhMOVdDbEhNR1IzS1g3ZGswY0RoU1Bsb1lGVDlu?=
 =?utf-8?B?V0UyaWw1clp2NE9WQWRpaDMzQ0ZuNmlKQ2NzVHNsUnhFa3ROYmpEZzNOR2ZC?=
 =?utf-8?B?ajJiMHI1T045S3dEV2NiYi9OSVRKaTVrTEhvOXAybUlzZ3VsbEVHOCtiUWE3?=
 =?utf-8?B?TlZRbS9VUW1YdGl3a1hTc0N3bkZSWnZJU1Y4ZDBHU3ZEQ2xZZFZVd0tGSWpn?=
 =?utf-8?B?OUk5dFBYeFZrejgzWUxrVFJGNDJtL3pLL2NjYS9mN0ZJSlhXbHVtakVjWjFi?=
 =?utf-8?B?OXBLWE1QbFBnN2VxWExoRmNqTXg2eFJTem84QzZ0Q2VCSlJoQkNrTWE1dTh0?=
 =?utf-8?B?VzdGcFJQZTJnUDVQbGRhaXNLTGRUYVVVVmJ3WlhtRFhlTHU3NmxRSWxEVHFl?=
 =?utf-8?B?Vmd3cDJpVjc3K2J4RWU4Q1hGQTk4anBiRE1LaXdXRkpGaWR6NWloWW42Z2RV?=
 =?utf-8?B?R1dHZUlORHV1TDJtYklnalRjVy84b2h4T1VmZkNERGltZG1vSlhyTE4ybGM0?=
 =?utf-8?B?YVlDZU5taXNiNFhOL3dNUUpNd3JTcVJhRmVYb2dkeUZjd29QZjhUZ3R5ZXJT?=
 =?utf-8?B?dGFrWG5IbEVpT2RobVQ5VUhnYVIrODFsNVJDR29aTVQ4L0JzZEdNOWIvcWh4?=
 =?utf-8?B?Mmc2UnlQRWVMNFEwUmxTai8yYmtKL2w3d214cXFUVXZjQllyblFhWDFXQkhD?=
 =?utf-8?B?RitrNGlYMTdyK0psdXRDcUtSbHVQby9nKzUxckJzNjJSbWJLYmdqZG1SbTdR?=
 =?utf-8?B?TEFyT0F2TWRDOUhvZ0NHcmRjeUoveVlEckNORVl3VWUrK0lXdnh4UUpwZDlE?=
 =?utf-8?B?cHcxckNVZGIzQ2hmTHVUZENNVWlxTEdZcDVrYWZXRlErM2pwbXAzRjJ0NWlY?=
 =?utf-8?B?OWlHL2FFWnk0Y0ZrbG1BWm5IenRYNDBPOE0vKzJsUXM5dDNLUGNDaVp4Nnlo?=
 =?utf-8?B?U0NCUG05LzVFck9BeUtpUG9QVFQ3ekp4KzhwSjVacUpwUmM4OFBoSmxKb1VE?=
 =?utf-8?B?emJiVnFUNjhxcXVPTFFOSmNLVVAvZjdOdUF5S2I5VEo1V2FubURHYWlvNVpZ?=
 =?utf-8?B?b3VaTWR4SlJnNkcyK2Evb1lDN2laZU84bUQyVm9DVG9JRUVhcGR3dVpORVh2?=
 =?utf-8?B?YWlDclNWcXJVeEdFMnFNWU9haXp5d2ZiV3NVK0NrOC9iTGN3d3ZiWG9WWUI5?=
 =?utf-8?B?cGZVTzhHR29MTmtCQTR2TC9kMGtpL0pNWlBVbmJBZU9mekFkWWhWNTFxNHlZ?=
 =?utf-8?B?ejVUS1hnUUJJVXRKaW1FOEQybjlPVmZNcUY3NjM1ZlIxSDIrOXpzVCsySEZk?=
 =?utf-8?B?RE1tK3MvNzFlVFZRcEJRR2hwK1JkampyWE1LQ25EU2ZKM0RJUnJnMWNwcVV6?=
 =?utf-8?B?VENiRjhzby9uYkcvbjArL3g2cU1BRExOVkRaSWVXelc1a0NySWRLRzdHUkNP?=
 =?utf-8?B?VDRnbEplcW9xdzBSYjB0NXZOYzUzLzdZTTduM21ETXRIVWx4N2g3Mm9BRzBy?=
 =?utf-8?B?TkEvQWJIOTdiS0Rydlhaa0ZpdmI5OHY4VStYbXJIQUk0TXUxSDU2WGNSNUEy?=
 =?utf-8?B?U2ZiZHFhaWhuWVpFRllaeFEweUJyY1hrL2FuVDJGRHVBWFdWTkFBcTY2QW5a?=
 =?utf-8?B?dGhzMXV4M3pPU0ZPb2gwb3R4dzRCMElLdlVxRjNCOXdET1NlUXZ5Z29hVlJS?=
 =?utf-8?B?RzVFa1NtcWswZDBHME9DNm5xOW82NkJ5T0ZqcUs0SUNQK3IwWFZza0JCMXZx?=
 =?utf-8?B?TXp0ZEx6NVk2T0Z4TkVMelJXM3crcWtacjFpcE9sZ3RuRElSY1NDN3ZrR3Vh?=
 =?utf-8?B?STVPVjRNYmxzc0RjQktTUkZnRXVKc2dDVGNYUkJoUjNybjY2WmVyeGc4TU1w?=
 =?utf-8?Q?ijuA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8599.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a66033-6f97-4696-dbbd-08dd0346313a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 18:16:56.4979 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZPR+6o6fNmO5Su+0oiHBtXlZ+xIjMG5S6ExClr7ymdQ4ns3NT/9C279NJGbFb0AhLZB0+QHMXKuZxte9QCkrBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
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

W1B1YmxpY10NCg0KPiBGcm9tOiBDaHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVy
a2VuQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTIsIDIwMjQgNTo1NA0K
PiBBbSAxMC4xMS4yNCB1bSAxNjo0MSBzY2hyaWViIFl1bnhpYW5nIExpOg0KPiA+IEBAIC0zMTAs
NiArMzExLDkyIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92bV9ib19yZXNldF9zdGF0ZV9tYWNoaW5l
KHN0cnVjdA0KPiBhbWRncHVfdm0gKnZtKQ0KPiA+ICAgICBzcGluX3VubG9jaygmdm0tPnN0YXR1
c19sb2NrKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICsvKioNCj4gPiArICogYW1kZ3B1X3ZtX3VwZGF0
ZV9zaGFyZWQgLSBoZWxwZXIgdG8gdXBkYXRlIHNoYXJlZCBtZW1vcnkgc3RhdA0KPiA+ICsgKiBA
YmFzZTogYmFzZSBzdHJ1Y3R1cmUgZm9yIHRyYWNraW5nIEJPIHVzYWdlIGluIGEgVk0NCj4gPiAr
ICogQHNpZ246IGlmIHdlIHNob3VsZCBhZGQgKCsxKSBvciBzdWJ0cmFjdCAoLTEpIGZyb20gdGhl
IHNoYXJlZCBzdGF0DQo+ID4gKyAqDQo+ID4gKyAqIFRha2VzIHRoZSB2bSBzdGF0dXNfbG9jayBh
bmQgdXBkYXRlcyB0aGUgc2hhcmVkIG1lbW9yeSBzdGF0LiBJZg0KPiA+ICt0aGUgYmFzaWMNCj4g
PiArICogc3RhdCBjaGFuZ2VkIChlLmcuIGJ1ZmZlciB3YXMgbW92ZWQpIGFtZGdwdV92bV91cGRh
dGVfc3RhdHMgbmVlZA0KPiA+ICt0byBiZSBjYWxsZWQNCj4gPiArICogYXMgd2VsbC4NCj4gPiAr
ICovDQo+ID4gK3N0YXRpYyB2b2lkIGFtZGdwdV92bV91cGRhdGVfc2hhcmVkKHN0cnVjdCBhbWRn
cHVfdm1fYm9fYmFzZSAqYmFzZSwNCj4gPiAraW50IHNpZ24pIHsNCj4gPiArICAgc3RydWN0IGFt
ZGdwdV92bSAqdm0gPSBiYXNlLT52bTsNCj4gPiArICAgc3RydWN0IGFtZGdwdV9ibyAqYm8gPSBi
YXNlLT5ibzsNCj4gPiArICAgc3RydWN0IHR0bV9yZXNvdXJjZSAqcmVzOw0KPiA+ICsgICBpbnQ2
NF90IHNpemU7DQo+ID4gKyAgIHVpbnQzMl90IHR5cGU7DQo+ID4gKw0KPiA+ICsgICBpZiAoIXZt
IHx8ICFibykNCj4gPiArICAgICAgICAgICByZXR1cm47DQo+ID4gKw0KPiA+ICsgICBzaXplID0g
c2lnbiAqIGFtZGdwdV9ib19zaXplKGJvKTsNCj4gPiArICAgcmVzID0gYm8tPnRiby5yZXNvdXJj
ZTsNCj4gPiArICAgdHlwZSA9IHJlcyA/IHJlcy0+bWVtX3R5cGUgOiBhbWRncHVfYm9fZ2V0X3By
ZWZlcnJlZF9wbGFjZW1lbnQoYm8pOw0KPg0KPiBBZ2FpbiwgaXQncyBhIGNsZWFyIE5BSyBmcm9t
IG15IHNpZGUgdG8gZG8gc3R1ZmYgbGlrZSB0aGF0Lg0KPg0KPiBXaGVuIHRoZXJlIGlzbid0IGFu
eSBiYWNraW5nIHN0b3JlIHRoZSBCTyBzaG91bGQgKm5vdCogYmUgYWNjb3VudGVkIHRvIGFueXRo
aW5nLg0KDQpJIGRvbid0IGhhdmUgYSBwcmVmZXJlbmNlIGVpdGhlciB3YXksIGJ1dCBJIHRoaW5r
IGl0IHNob3VsZCBiZSBhIHNlcGFyYXRlIGRpc2N1c3Npb24gdG8gcHJvcGVybHkgZGVmaW5lIHdo
YXQgZHJtLXRvdGFsLSBtZWFucy4NCg0KPiA+ICsgICB0eXBlID0gcmVzID8gcmVzLT5tZW1fdHlw
ZSA6IGFtZGdwdV9ib19nZXRfcHJlZmVycmVkX3BsYWNlbWVudChibyk7DQo+ID4gKyAgIHNoYXJl
ZCA9IGRybV9nZW1fb2JqZWN0X2lzX3NoYXJlZF9mb3JfbWVtb3J5X3N0YXRzKCZiby0+dGJvLmJh
c2UpOw0KPiA+ICsNCj4gPiArICAgaWYgKHR5cGUgPj0gX19BTURHUFVfUExfTEFTVCkNCj4gPiAr
ICAgICAgICAgICByZXR1cm47DQo+ID4gKw0KPiA+ICsgICBzcGluX2xvY2soJnZtLT5zdGF0dXNf
bG9jayk7DQo+ID4gKw0KPiA+ICsgICBpZiAoc2hhcmVkKQ0KPiA+ICsgICAgICAgICAgIHZtLT5z
dGF0c1t0eXBlXS5kcm0uc2hhcmVkICs9IHNpemU7DQo+ID4gKyAgIGVsc2UNCj4gPiArICAgICAg
ICAgICB2bS0+c3RhdHNbdHlwZV0uZHJtLnByaXZhdGUgKz0gc2l6ZTsNCj4gPiArICAgaWYgKHJl
cykNCj4gPiArICAgICAgICAgICB2bS0+c3RhdHNbdHlwZV0uZHJtLnJlc2lkZW50ICs9IHNpemU7
DQo+ID4gKyAgIGlmIChiby0+ZmxhZ3MgJiBBTURHUFVfR0VNX0NSRUFURV9ESVNDQVJEQUJMRSkN
Cj4gPiArICAgICAgICAgICB2bS0+c3RhdHNbdHlwZV0uZHJtLnB1cmdlYWJsZSArPSBzaXplOw0K
PiA+ICsNCj4gPiArICAgaWYgKGJvLT5wcmVmZXJyZWRfZG9tYWlucyAmIEFNREdQVV9HRU1fRE9N
QUlOX1ZSQU0pIHsNCj4gPiArICAgICAgICAgICB2bS0+c3RhdHNbVFRNX1BMX1ZSQU1dLnJlcXVl
c3RlZCArPSBzaXplOw0KPiA+ICsgICAgICAgICAgIGlmICh0eXBlICE9IFRUTV9QTF9WUkFNKQ0K
PiA+ICsgICAgICAgICAgICAgICAgICAgdm0tPnN0YXRzW1RUTV9QTF9WUkFNXS5ldmljdGVkICs9
IHNpemU7DQo+DQo+IEFnYWluIHRoYXQgaXMgaW5jb3JyZWN0LiBCT3MgY2FuIGJlIGNyZWF0ZWQg
d2l0aCBWUkFNfEdUVCBhcyB0aGVpciBwbGFjZW1lbnQuDQo+DQo+IElmIHN1Y2ggYSBCTyBpcyBw
bGFjZWQgaW50byBHVFQgdGhhdCBkb2Vzbid0IG1lYW4gaXQgaXMgZXZpY3RlZC4NCg0KSW4gdGhh
dCBjYXNlLCBkbyB3ZSBjb3VudCBCTyB3aXRoIFZSQU18R1RUIGluIGJvdGggVlJBTSBhbmQgR1RU
J3MgLnJlcXVlc3RlZCBmaWVsZD8gYW5kIGlmIHRoZXkgYXJlIG5vdCBpbiBlaXRoZXIsIHRoZXkg
Z28gaW4gYm90aCAuZXZpY3RlZCBmaWVsZD8NCg0KPiA+IEBAIC0yNjEyLDcgKzI3MDcsNiBAQCB2
b2lkIGFtZGdwdV92bV9maW5pKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiA+IHN0cnVj
dCBhbWRncHVfdm0gKnZtKQ0KPiA+DQo+ID4gICAgIHJvb3QgPSBhbWRncHVfYm9fcmVmKHZtLT5y
b290LmJvKTsNCj4gPiAgICAgYW1kZ3B1X2JvX3Jlc2VydmUocm9vdCwgdHJ1ZSk7DQo+ID4gLSAg
IGFtZGdwdV92bV9wdXRfdGFza19pbmZvKHZtLT50YXNrX2luZm8pOw0KPiA+ICAgICBhbWRncHVf
dm1fc2V0X3Bhc2lkKGFkZXYsIHZtLCAwKTsNCj4gPiAgICAgZG1hX2ZlbmNlX3dhaXQodm0tPmxh
c3RfdW5sb2NrZWQsIGZhbHNlKTsNCj4gPiAgICAgZG1hX2ZlbmNlX3B1dCh2bS0+bGFzdF91bmxv
Y2tlZCk7DQo+ID4gQEAgLTI2NjAsNiArMjc1NCwxNSBAQCB2b2lkIGFtZGdwdV92bV9maW5pKHN0
cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LA0KPiBzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkNCj4gPiAg
ICAgICAgICAgICB9DQo+ID4gICAgIH0NCj4gPg0KPiA+ICsgICBpZiAoIWFtZGdwdV92bV9zdGF0
c19pc196ZXJvKHZtKSkgew0KPiA+ICsgICAgICAgICAgIHN0cnVjdCBhbWRncHVfdGFza19pbmZv
ICp0aSA9IHZtLT50YXNrX2luZm87DQo+ID4gKw0KPiA+ICsgICAgICAgICAgIGRldl93YXJuKGFk
ZXYtPmRldiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAiVk0gbWVtb3J5IHN0YXRzIGZvciBw
cm9jICVzKCVkKSB0YXNrICVzKCVkKSBpcyBub24temVybw0KPiB3aGVuIGZpbmlcbiIsDQo+ID4g
KyAgICAgICAgICAgICAgICAgICAgdGktPnByb2Nlc3NfbmFtZSwgdGktPnBpZCwgdGktPnRhc2tf
bmFtZSwgdGktPnRnaWQpOw0KPiA+ICsgICB9DQo+ID4gKw0KPiA+ICsgICBhbWRncHVfdm1fcHV0
X3Rhc2tfaW5mbyh2bS0+dGFza19pbmZvKTsNCj4NCj4gUGxlYXNlIGRvbid0IG1vdmUgdGhlIGNh
bGwgdG8gYW1kZ3B1X3ZtX3B1dF90YXNrX2luZm8oKS4NCg0KSXMga2VlcGluZyB0aGUgdGFza19p
bmZvIGFsaXZlIGEgaGF6YXJkIGhlcmU/IEkgY291bGQgY29weSBvdXQgdGhlIGluZm8sIGl0IGp1
c3Qgc2VlbWVkIGEgYml0IHdhc3RlZnVsLg0KDQpSZWdhcmRzLA0KVGVkZHkNCg==

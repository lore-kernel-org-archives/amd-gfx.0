Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F465C3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 06:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE65A10E8C4;
	Thu,  8 May 2025 06:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gPW4Hi/w";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 668DC10E8C4
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 06:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1CzLwWSsTsKHTrQ3byzsRjGnirHPM7km3ITntSbt5cD17b6uk1VqKzIT2GipaXncGGKv4mykGINs0SMuDOxAASI3KbueWQE66UVU5gzgujXNksZMO+bFLECnPCKzy4/eu90zaZhqM5W8tK4hwNPld2d2UHqJ6ZEyA2tAVUs5R24MOWG/5ZIWybSWVgZzs1H8xUWZlNadahUIAHA/hcYlIX597HnTJgwEbBSFheuiXVW23D2FoRdrq3i+DlOl2XGqTvJ2BXmZNCoQJh649oxx2GXN/HYuntCcErXM39vZ+YPH2qeZKaJMsXatfZWJ+yW28Iu6jZmKU93mlWPCBUroA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eEyPA3e7RUPcmWo1cD/UtSsmfqHBg9ahXZBMCKCzNg=;
 b=Rkm1An9lqBMM3F/U0Vsmt7CcVS3mJlcbGagYCEXsvHy/sw9Uz8bdZX7Sja/x3SA37uoOwpGD8lT0LzcUVz2rJ5/NO1EtfAJ15LpFGwJoYlb0Yffviu86Sd3ttWqRdbdvU2dP4rdWnbbTwJ4NRiLPsHlKt84QIXDjDdVLTHWpiBgfzzedR4W6mCcus+PbSLlOBnTQYVn2MxiQE1CYJQzt+JuG2rVhnCc06iSyhmwuLZ8QeKoeKIAXRCq7x5fuzJ8N4UNhtdrfM/O+h6iek8hH4Olmfy4p3E4dQyvzai4FRIYsNmEQ/ObCBPRXPl8lBJ+gTVaiL0uH8keEZ/gZPnvzFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eEyPA3e7RUPcmWo1cD/UtSsmfqHBg9ahXZBMCKCzNg=;
 b=gPW4Hi/w8qtosuqWbyxPLqr31zr5k4+sxrOPdk6EfMuTwLruDjxT83egCrQjy7x1NoCKj+2P6uUW8mGdYjY30GZdYUXsBACREstj6YUz6cy9InGvynjpQgG7AHYVd2SV/D7x/+7XuOpTnJrM5LXu7qjmLHUJxhKEdx/NN/Q5pOE=
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 8 May
 2025 06:53:45 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::2b0e:7fc3:1d21:5d2e%3]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 06:53:45 +0000
From: "Khatri, Sunil" <Sunil.Khatri@amd.com>
To: "Yadav, Arvind" <Arvind.Yadav@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, kernel
 test robot <lkp@intel.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Fix amdgpu_userq_wait_ioctl() warn missing
 error code 'r'
Thread-Topic: [PATCH] drm/amdgpu: Fix amdgpu_userq_wait_ioctl() warn missing
 error code 'r'
Thread-Index: AQHbv+FP+g9FPoIoUkSIDJgpBMpffrPIS+cA
Date: Thu, 8 May 2025 06:53:45 +0000
Message-ID: <BL1PR12MB5753BD369BEA5B1E2086B95C938BA@BL1PR12MB5753.namprd12.prod.outlook.com>
References: <20250508062015.120380-1-Arvind.Yadav@amd.com>
In-Reply-To: <20250508062015.120380-1-Arvind.Yadav@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=f0706eb4-8a80-4bfe-abf4-8630e8bc4e11;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-08T06:52:58Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5753:EE_|CY3PR12MB9577:EE_
x-ms-office365-filtering-correlation-id: 3896e2c5-88a1-4844-206e-08dd8dfd13af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?VFBEZ00zSVF4NHBqVk5lUkQySGpjbHRwbUhLR2VKRzlzTE9MRkNLRnhFTVRH?=
 =?utf-8?B?Ykl2NHo1NlBCVEJBKzNjZStjWHZvcUptK3lSQUEvZkZOOEZxcW96ei9qUkJ0?=
 =?utf-8?B?ckFxN0crSGd0UmMrNktwbU1CaEpGSkF3U1Z1Ry93VHo2UmdIVGlUTjh2TW53?=
 =?utf-8?B?cE1nV3FZYTExU05Nc3ZrNkJqSThqQ1UxQXFMNTVxWjZDVnlzaTVwdFpKWDdP?=
 =?utf-8?B?K1BGelROMmNiVmcwbG5CVGMreDVXRzlYb3dVY2huN2JhL0thdXdWNG0wVEN4?=
 =?utf-8?B?REM5R3ZqcWgwU2c1aXdCTVNzOEVTM3ZZNk1OOGQ5eFl0aVNhMHlvdmdvZ1lO?=
 =?utf-8?B?SmpqR2pqK1JiaEFRNEdGVm9vYmdUQlZCOFhjTmFJNzBWR2JybHBydXFPUERC?=
 =?utf-8?B?ZU9kLzRTQkh6c2hWVklEcXYxN29mUk5LclNmMEVDYitMOGZpNW4zQmVOYnho?=
 =?utf-8?B?dVFRWCtyNnZTR01KZmQ1NHhUK1Nic0N5UE9iZ0NrK3p0eDJtb1VPNURtdG9l?=
 =?utf-8?B?OVBOZCtkQ3B6cFVkR1JFSkwyc3hvOWsybXVMaUtlYmxBSmVLTDJMOWNscTJN?=
 =?utf-8?B?c1VmRTV5VU9wSlJEdW9CZ2ZZdDhjSTJDS0VxK3RSeWVqTTNDYTd0Sy9yYXVk?=
 =?utf-8?B?aksrQXo5VWFVUGR4ZEJyRjl5Y0xpdnZPb2ZyTUVoNDBXZmRZRlFFaFNEL3l2?=
 =?utf-8?B?MmxRWG1XMk5QQkp5Snhia3FRbHFZbjhkZDVLamdUZnRsN2FJRXVteHNBZFVS?=
 =?utf-8?B?em81clgvdDlJRTY2aDQ1cDBveEtQVWlNNlREWVFLcDFMUlA5cTArTjdDKzlN?=
 =?utf-8?B?UVJvN21pU3RCa3FYZ1JHQ0l0UVlkWSt0YTgxUk1sbHNCY05YWlkveXBXTG91?=
 =?utf-8?B?bCtYVzJuQW1TZWpNZS90ODI4U3V6M1didWMycEVNMFpXYzF3YSswS2dUcWY4?=
 =?utf-8?B?RnZTUXpVRkJuQ1lhN3daN3FQOUZLQk9OcXowS2xaT3RBR1dwSFpnbVJ4U25X?=
 =?utf-8?B?MFVsQ0t6dzNiT2VZVlZSdmE1RGRpbGNKOW9aYXVmZjhFK1N0aHZmSmZheFhp?=
 =?utf-8?B?bkdmeFJsZmg2U0t2Z1dlZWFmTG9ybVJMTzF3V0Q2Uk5ycVkrb0VwNDJ3TEMx?=
 =?utf-8?B?MlBFMEZ4VzV4eUZGelcwanpYcjBkWUYvaStzU3R2aW5JNFo1ZXZGeWVweVd3?=
 =?utf-8?B?bERibGZzWDhGN2c3M3FQcUFkOXRrWVdSSWlLUU84MWxVYURiY0p6cVoxcEVn?=
 =?utf-8?B?UHA1UXM0UVlEbkZoZ3c4cGZGOWExTFF0MVczakxVQ2xSN3FhZCtuM3Awemd6?=
 =?utf-8?B?YnJ5SFpDeFlNcmNtQS92a1lSTzlhNTZVeS9uQk84WFp6OHcyZmU0czlMdVo1?=
 =?utf-8?B?Smo4aSt0dUovclRrWDV2K24vRVNHc1paa2x1d0Ruc01EQ1dwVkhUdkFVaG5m?=
 =?utf-8?B?K0kvT2dqN29UUDN0eENhVWtPR0F4ZFdFYVJsTDJUT3FCa0VpUW5oUFpQZ09m?=
 =?utf-8?B?WGk1ank0eUN1cEQ1UHlRTlovdVEyd0Nvc0pBTzE5SXRmaDBpUjVoOTNXWUFS?=
 =?utf-8?B?MnBYL1lTTUVqeld2K29WbW04VWhQVG13SkdNMjUwb2w3c1Y5bWZXVlhUYnhC?=
 =?utf-8?B?ZnFBT2diSlhoRGhGd0VLQWpJb3FiQm5kdEFzOGM5Q25BeDRwUFZGZ25pUVl1?=
 =?utf-8?B?SVpNZllwTlpwUVdHcmtUYmRSeW5CV1dMM3EzczRwQXNTanRxK0VzQTJyc0U3?=
 =?utf-8?B?ZmFPQmQxd1JCb0hpRUw2YUxId0Z5R3UxcmtqdTR1R29uZUxOMXFlUmlqL052?=
 =?utf-8?B?RXkyMEhCVWFmVUI5NHl0ZXZydjVuQ1o1ejNVazF2bWdQTFlEVTZwQWRBUFlS?=
 =?utf-8?B?WUhYYkh3THJ4ZHJpU294QUtBY3diWG5vWCtlOG9EVTBVSkVDRjh3Z1RaaCtL?=
 =?utf-8?B?SGZNbnQ4a3g3aEZFek95cXdvek9SRXhoZnFnVVNHS2xBOENLZXp0Q1RYcFpE?=
 =?utf-8?Q?S9UpTyUKZTBSRIxcuU8vBAbuv5p7Zw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHB0SEhNWUtaSGNBNnNJREhqekd5ZUdFMlFoNUFEQm5LYyt5NkpxUzFYelh2?=
 =?utf-8?B?bXp5UnJZL1l1bXZTNUh5WGgyQU5YMGhPZCtZeU95MVFrTzM0U3daOE03QURt?=
 =?utf-8?B?WnMvaGxKcVl3dFlySGNRcWJCUWJ4SDc0UDhrU0c3cGx3T1c4cUpRcStaMEwx?=
 =?utf-8?B?RUYwNjNSWVFkY0pRL1ArblhjK0JHdFNDcmYwVEhLd3JUaG00cGZHMHNsa21B?=
 =?utf-8?B?SE1Ja2dXbUVCenp1ODBzbVVKWU4yZk1WU3BMK3FqOTBFdzU3Vnoyb21KV0d2?=
 =?utf-8?B?T1FrTnBrOXJHZlJVRlNQbEVONEg0ZUFvSXZ1Sng2T2hkbm14TXpza2JqY2VH?=
 =?utf-8?B?bFJMcG1lU3RVOUp6S3RmUDN0V3l4Zk9qejVUL1pEdmdsOERVbnBsMlA2Vjc4?=
 =?utf-8?B?TlVWcW5ZeExKMStyZ0dkM2tQRzZBUEliTURFWTVoZkpaRVlCdmpPMnNhYzNG?=
 =?utf-8?B?Vk1oRkx0WGRuT2h6VDdpWUU1bm01eFM5WGpJc2RkcHlIM1A2dFRzb2s0eWho?=
 =?utf-8?B?bFpsUzdMVjh1QlhRVGtzSnNvTit2OWZ5ejZYekFHOHU3a20vMFZzQzhNNUt2?=
 =?utf-8?B?N1ZCb2l1dWJtcHVCTFJ5UnZJUzRwclZSVkVBT0RXVmVUZXJ6MTFmV2laQWVk?=
 =?utf-8?B?dGFVSXMyUVNwd2x4Q1M3YVAxMlZpVmUwcCs5SkliZjg2VnJlZnRYaEJrc2xm?=
 =?utf-8?B?ZDl0RmpVS0h2WW5nSFNZNGc1WDl3eTArU01rbkdkRXFMVEIrZnd3UGpIWElD?=
 =?utf-8?B?Y1htenFOeW51aDBCS3VieUExWjJGZnAzYzd0OWtkZ3NwMXdaZ1lkbGxzeDl2?=
 =?utf-8?B?dURCMnh6TjkvQkF3RTBZNHFqaGZPN05PZnZnelg0VnYzT2JUNk9HOE5MTjV4?=
 =?utf-8?B?MmZKZVFCbzNyUUtTQVF2N1NlNXJtZG9JN0lXZUFvZWVnYUJUVmZaS25vQURZ?=
 =?utf-8?B?Wmt1Qzl5M3crTDZxRW1Yd0dXR0V0RjFSTGVpOEJxc1lLTG5QNlBNRlhQOEpD?=
 =?utf-8?B?T3BVS0h2MnFOMW9XY1ZCaVN0REt5bzZONjFSQ0hoOVVUQnZDWTMzbjVWYkR0?=
 =?utf-8?B?dVNHMzhiZy9SRmw4alc0N1ZtTDV4YTVNcVliTU1ZTUZjeWwyMUlmK0Rmdkha?=
 =?utf-8?B?RzdDVkRla3B5aUdsTldaT3FraTAyelVhdTJOc082NmhUbVd2akd6WFFpanc1?=
 =?utf-8?B?QkRjQ1NOR0FMdnpHU1NYSzR2UkZZWlVpaENNM2dkeXBRanhLVGs5SnZueUhF?=
 =?utf-8?B?WUxqM0ZOSmp0MGJwaDN0NThKOXY3WDhweTE1MHF5SHZJUUVRLys0TGdDSW5t?=
 =?utf-8?B?K3k4L1N1bWxYTzB5R2gxQzFRajRwVFJUc3VDS0VTbEZkSUhhdjQzN21PeHZz?=
 =?utf-8?B?RDBLbTNFZHp6ZEEra2dsMW56cWNNUkZSU3RKVWNqbmE1dGZZZ3pjSnhjSXN4?=
 =?utf-8?B?ZVVhalU1U3FMQmk2RW5OM0ZZWWdQcVplaHRpdUZ0VVVMcFZZLzUvYUpzaXho?=
 =?utf-8?B?ZzV3dDBoaVdZdVZoejF1UFl6cEQzTEZ1eXNKME5QbERSQWZULzc5WXhoVDVF?=
 =?utf-8?B?MHhWSWpSa2hkVU0zN3NhWDNsei9KbEN1YWJiSlVZSlNWbTZ4WG9KVlBnNnNw?=
 =?utf-8?B?OHM0ejZxbUtnNlNMK3c1a1MvaGQwdk1SNnBzbTF6WnNqZUsyR1hENFFTMS85?=
 =?utf-8?B?K0Fza3czWEJpWWVxNzZrZVc1b205aHN3TEJWOHM0K21JbW9xbmVXd1VNOTdF?=
 =?utf-8?B?VEhHdnR5cVFDZjJuTGFjMUpqbnVUSXBGWHRYWi9iZmNGUTdDWEMvYUxvSDB2?=
 =?utf-8?B?QjlvcUpoZXhNb1RRS0lIQWFXNXNyQWloblcvSjdHVmdDWVNjY0tYVmVTalds?=
 =?utf-8?B?aXMwckNGWUh1Q2hQMi9YMGVRVWtTUTZvSXVGTi9FM2dsMmlxaWMwNVJDVjQ3?=
 =?utf-8?B?NU9tM3VnbGtiZTcwdWxHN3d0eDluL0VCRVBrSEg0dVhmWTlFckVRc1pJQkZu?=
 =?utf-8?B?aU41N0sxOVdLM2tqU1drRG9Jb3pPRUZkZlNQZk5BcWcrak9TRmtNYjk1SmZw?=
 =?utf-8?B?WDlwL1FQNStXemU2b0tCcjNtdXFXd0dkelJNT0toK2QrMnJlZEptbW1RMTFH?=
 =?utf-8?Q?kYi4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3896e2c5-88a1-4844-206e-08dd8dfd13af
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 06:53:45.2570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmSYxCaAJkbeP+Y+CS8rGcC2Sv9gFc7ZDhYJGe5fPcUO2UE4fyuvje0GDotfrwKsX6vEKaUSbJIpDhHBYPtTVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577
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
Cg0KUmV2aWV3ZWQtYnk6IFN1bmlsIEtoYXRyaSA8c3VuaWwua2hhdHJpQGFtZC5jb20+DQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBZYWRhdiwgQXJ2aW5kIDxBcnZpbmQuWWFk
YXZAYW1kLmNvbT4NClNlbnQ6IFRodXJzZGF5LCBNYXkgOCwgMjAyNSAxMTo1MCBBTQ0KVG86IEtv
ZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBEZXVjaGVyLCBBbGV4
YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBLaGF0cmksIFN1bmlsIDxTdW5pbC5L
aGF0cmlAYW1kLmNvbT47IFBhbmVlciBTZWx2YW0sIEFydW5wcmF2aW4gPEFydW5wcmF2aW4uUGFu
ZWVyU2VsdmFtQGFtZC5jb20+OyBkYW4uY2FycGVudGVyQGxpbmFyby5vcmcNCkNjOiBhbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgWWFkYXYsIEFydmluZCA8QXJ2aW5kLllhZGF2QGFtZC5j
b20+OyBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT47IEtvZW5pZywgQ2hyaXN0aWFu
IDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQpTdWJqZWN0OiBbUEFUQ0hdIGRybS9hbWRncHU6
IEZpeCBhbWRncHVfdXNlcnFfd2FpdF9pb2N0bCgpIHdhcm4gbWlzc2luZyBlcnJvciBjb2RlICdy
Jw0KDQpUbyByZXNvbHZlIHRoZSB3YXJuaW5nIHJlZ2FyZGluZyB0aGUgbWlzc2luZyBlcnJvciBj
b2RlICdyJyBpbiBhbWRncHVfdXNlcnFfd2FpdF9pb2N0bCgpLCBhc3NpZ24gdGhlIHZhbHVlICdy
ID0gLUVJTlZBTCcuDQoNClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVs
LmNvbT4NClJlcG9ydGVkLWJ5OiBEYW4gQ2FycGVudGVyIDxkYW4uY2FycGVudGVyQGxpbmFyby5v
cmc+DQpDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNTA1MDgwNDU4LnJuVjhZ
ZmlZLWxrcEBpbnRlbC5jb20vDQpDYzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBh
bWQuY29tPg0KQ2M6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4N
CkNjOiBTdW5pbCBLaGF0cmkgPHN1bmlsLmtoYXRyaUBhbWQuY29tPg0KQ2M6IEFydW5wcmF2aW4g
UGFuZWVyIFNlbHZhbSA8QXJ1bnByYXZpbi5QYW5lZXJTZWx2YW1AYW1kLmNvbT4NClNpZ25lZC1v
ZmYtYnk6IEFydmluZCBZYWRhdiA8QXJ2aW5kLllhZGF2QGFtZC5jb20+DQotLS0NCiBkcml2ZXJz
L2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdXNlcnFfZmVuY2UuYyB8IDQgKysrLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91c2VycV9mZW5jZS5jIGIvZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCmluZGV4IDMyODhjMmZm
NjkyZS4uODRiMDUyZGJkZDZiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X3VzZXJxX2ZlbmNlLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV91c2VycV9mZW5jZS5jDQpAQCAtODUyLDggKzg1MiwxMCBAQCBpbnQgYW1kZ3B1X3Vz
ZXJxX3dhaXRfaW9jdGwoc3RydWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSwNCiAgICAg
ICAgICAgICAgICB9DQoNCiAgICAgICAgICAgICAgICB3YWl0cSA9IGlkcl9maW5kKCZ1c2VycV9t
Z3ItPnVzZXJxX2lkciwgd2FpdF9pbmZvLT53YWl0cV9pZCk7DQotICAgICAgICAgICAgICAgaWYg
KCF3YWl0cSkNCisgICAgICAgICAgICAgICBpZiAoIXdhaXRxKSB7DQorICAgICAgICAgICAgICAg
ICAgICAgICByID0gLUVJTlZBTDsNCiAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9m
ZW5jZXM7DQorICAgICAgICAgICAgICAgfQ0KDQogICAgICAgICAgICAgICAgZm9yIChpID0gMCwg
Y250ID0gMDsgaSA8IG51bV9mZW5jZXM7IGkrKykgew0KICAgICAgICAgICAgICAgICAgICAgICAg
c3RydWN0IGFtZGdwdV91c2VycV9mZW5jZV9kcml2ZXIgKmZlbmNlX2RydjsNCi0tDQoyLjM0LjEN
Cg0K

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34059C35FF1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8B5410EA02;
	Fri, 14 Mar 2025 14:43:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BtLNHP9Z";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F249B10EA00
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM3Ug3NzOkM6GW6J3pz7J9AmlGRJ3mX5UAP2Hilbm7XSIazOHYq4/ZNJ6radsqZm+HrPp7Qm0ohuKs2U0M3+tW3dRC49ABNCieT6ROdHMOjRu767iRyHqbwuXU5QrfRaWQv/alZlgHvDMFciWW9lACc8XGzsIv01WUwxzOIsRjlcyy0TSC4GjeMgMUajdSf1MNZpmDroZWzCajZBh8A9SfRK7fJ5JdwFP7wbCR20ubaTJObNq4EwOKGLU+2d6TZQXI4/CuKyw9YIKEgv3hnPiMHnLLx9dCA6ghNhwMIH5dPzdY6mNd4W8oOlEuVR0f2jl8pYcV5W+YEa+CDnmMDaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=onWZcxy2eeyENoICm07TgsnW2CPjozWoG5242Nxmb9U=;
 b=C/1ZWV284BdyRUFXGUyCg6D4mxuPDWPaqLHtI75qTcMkWnNGUxKyla0r+I6Fk84u7j0cK5oe3ABF52Jwgp6fKIFv8hCndSBfDBpwU0TRU85PpV6EP70bWxJvdW6gYi/jo5HxWGbUgwR+GXy3roCVekghtVXZM0TXyYZHkrO8Ly5W2zJ19wY+Zmc1HpBOr93XvpEOIM9CJAWjRYbbsJr5LQh51sZ+PFjYPtLiP13EBIlZFWhbgVWrX53XKrBZEyZvFJDN84rlqAWF7OluMYkSjRUlGfzfhWpJ1H2eBZdgP0ZiHNB2lkQR5x6xohBetDzKhSWb9w/wP9hhCwKk4rI9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=onWZcxy2eeyENoICm07TgsnW2CPjozWoG5242Nxmb9U=;
 b=BtLNHP9ZtN2A6uuyT+zHe3BHwKE/GynBiCF8Q+xbi1eAovxkjRAeYr4KYri7RN4JMJIRFdjKgYMN97sB6szGPVo2TpF0thFOdTQvYhZcKm3B1/FL1sC25R+3KEyMwfd2nV83Y8PLNy+MmHjeptJ3ee8BUF0lnvjV4OOMELiERa4=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 14:43:48 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::817c:781e:25f1:8210%6]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:43:48 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Zhang, Jesse(Jie)"
 <Jesse.Zhang@amd.com>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Zhu, Jiadong" <Jiadong.Zhu@amd.com>
Subject: RE: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
Thread-Topic: [PATCH 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
Thread-Index: AQHbkyTOidD6bImoHk2fKJQ1xwruFrNvJQsAgAACYACAAAaggIAADJqAgAHqIgCAAY+SkA==
Date: Fri, 14 Mar 2025 14:43:48 +0000
Message-ID: <CY8PR12MB7435D0FB256074CE1341DE5B85D22@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
 <0bc3ca8d-8a65-472d-ae63-ef570d08d1ca@amd.com>
 <DM4PR12MB515277590EC11D3757BB448FE3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
 <dcf2a1b5-f079-41e1-b310-79db0b927272@amd.com>
 <DM4PR12MB5152C8596272C0BED39068B4E3D02@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_OG3g8fasdXoPRN8UZoqy5vsdnO7Hn9KY3ygbT-Re1zUw@mail.gmail.com>
In-Reply-To: <CADnq5_OG3g8fasdXoPRN8UZoqy5vsdnO7Hn9KY3ygbT-Re1zUw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=2e20f12b-6110-47bd-96ce-c750f6f99703;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-14T14:28:34Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ2PR12MB8034:EE_
x-ms-office365-filtering-correlation-id: 9a08515b-8fbf-40e9-6166-08dd6306a169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3NnUVpnaVhCOHpxS0Naa2FzeDJ0eWErMXVmdG9SQWFSMUhTTVcxZGw2bENp?=
 =?utf-8?B?RXBXQ2VPQmZyMDQ0NnJQZXZNR1JreFBnOWNrdDBoYmtSeWp6Z2hDQ3lERG9Y?=
 =?utf-8?B?ZEo0K3Z4TWlkZ0xsQitPTk84YTF1NXp2YUJNbDJGSldwNTk5Tzc0WlVneWMy?=
 =?utf-8?B?VTgyQ2lMN2VBVThyL2owK09mUUQwZ2NFUXUzb1VGRi94WTRZcUVpZGhlTzZn?=
 =?utf-8?B?dGdhZzAwcHhPZUNBUW1pTXpTZ2E3b0RWK0ZoMG8wM3N1YS9ZZUVMYlVuaTVm?=
 =?utf-8?B?bEVLVTFpWWFSYWZiSXBCZzRubDdQMWRmaWVacnl4cjdyN1k5aFRETXgyZlpw?=
 =?utf-8?B?WmtIaU5WMXpjaExoSDZXRWczZTFwc0hrUzAxUUFnL2Zza2J6bk1vY0NIdVdU?=
 =?utf-8?B?Zm4xTkdneVVOcWFIU3dhazMydlArQTg5T3hmbDhDc2s2eUNOcXcrTTdUSnN2?=
 =?utf-8?B?VUxLWW83OEd4Vm9uRWRjdDkyODRpc0lsRWxyUUVSaWlEVmY4K2lLMkRaUUJX?=
 =?utf-8?B?YWIrVFlpd3pSV0kzVmQ1WGIvZVpJa044NHUzQ2NNVjJzWFZSWW9nK0pWN2FP?=
 =?utf-8?B?T0N1WkcrdG1YS2VlYjFmL2RGUjAyTXZWSTN0aGRBNTZVYURqTVN2YUxCMGpm?=
 =?utf-8?B?elJDRTcrSGdQa0FScXB5cHBkck5ERzBCOFc5L0NPWW1lSDc1WXVVVEVuM3Zz?=
 =?utf-8?B?MmZDWjVLcUhnaFZOZkRad0xXMy84ektiK2VFTXluUStvMnlCdjM5Z0FVN0dR?=
 =?utf-8?B?R1NZR21heHhBdFBwb2xlalJZbnBoMVFUY05kc3RMdjN4YzZMZjAyVGQ2ZkZj?=
 =?utf-8?B?Ly9JdENoWjZreUhYeDlvRHVRd2h0WUNsYVg4SUl1eTViK0ovNlg3RmROWkFB?=
 =?utf-8?B?RHNPUkVkNDJLYS9LakVYOU1BTzhldUN5emlPTGUyZXYwT2NuYXE2NVJ0SEVh?=
 =?utf-8?B?bityQWlEanU2a3JaekNzQXAzWFdyWkdyZmcvSHZPMnlCL1ZDSzFIOU1zZitW?=
 =?utf-8?B?R2c3VUhxekdOblFJWk02Tno4TXVNdFNjczR2eTlqZWtvRFlaN1hNeDZOZHdN?=
 =?utf-8?B?R3JvNWhqV1doVENhUGZyMnh0Vnl4MkZIVzY2T1pOdEthKzlIbGl2SlF3bWVx?=
 =?utf-8?B?c3VnRDZWUklESEpGT2NJQkcvN0NxNkRxbjNkSjNOR1JOR0Z6MFNwdHRMVkMr?=
 =?utf-8?B?N3F6Q2tvbW40RDlQcGRPMkVWekQ1MjRqRVJZencwdEZnSHFpcS9ZUTMrT1g5?=
 =?utf-8?B?dGhsWVFOeDlVZ2tHOTVwOFVubjZSZXIweGpLa2tic1M0L1RxeWFXNGphWWpj?=
 =?utf-8?B?M3dMaHZhQ1ZFYTZobFVDUjR0TWV4NVIrbUpnNHVndVMxanVUZkVCU0Z4NDRB?=
 =?utf-8?B?ai84dEMveitxd2dYb1FCeVpVQVBXMVRjZ0FiZzFpd1F3M01VbDJoVjI3MUVQ?=
 =?utf-8?B?WnJTVXl0WlFLdUhDZ3pldTlVZnoxVEU1OVFSejRpL0R0Tkl0N1U0djBYTnUy?=
 =?utf-8?B?b2lJL3FnVmhDL1VDNDFpZ1pUamJhS29sUlplMUhmanV6aUZwNEpPcXNHVWhl?=
 =?utf-8?B?aS83NWtHOTN4QXZ6bXRQTUhYM2h0QWNydnM4bG1FWmV0MElkYlVuWjdYekVz?=
 =?utf-8?B?UE8yZEpsOXFQOGZ1UTVYblZqWENkUUFsN21ZMW96V1JlOVhMS2dyYmd5cy8r?=
 =?utf-8?B?bGJWTFBvcnNZc3BTVkZOODYxS0JWdkkwakNqSTVIb2FFMDhGekFXSWlHT3d4?=
 =?utf-8?B?YTZpRktHWGRUQzNyQTVrMm0rR0tkYjV4TE9HRU14VkFzMEFGM1d4bDNNUGJ0?=
 =?utf-8?B?MmMrUHZIUTkwdnZrNlQ2WVdUY3MyOHBocDZMaDBvR2tZVnlhZUd1NFZFaVNp?=
 =?utf-8?B?cEYrUytLRWswOFVOL0lMb0xnV2pzc3E3TWhOTzhOTjZ1R2tKOUdoSXVPTHFp?=
 =?utf-8?Q?2fRbYLh+HiupzWXeDc/1XmgGThp9v36m?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVNRaUZZWDVVNjNCdmMvYjhHSnM1RGkrZXBvWktVSkVSVm9hY0ZwdlYrNVo2?=
 =?utf-8?B?dHlyd2VmclBlNjEvdnI2V2ZFeHdCV1pEZzlLSWpMQlYraHhKMWtyKy85djFL?=
 =?utf-8?B?TXZ2emllcFM2UUtVWXl0emRUUmFHd0dNVE5PUFRwM21WNElRYzJWVDZEY2xo?=
 =?utf-8?B?cW9uZ1FzUnlRdCtOaTVGdmxKc2tLaEh4RUpWR1FicjNSKytvbzhPWGJDbmhD?=
 =?utf-8?B?WWpka1JDeVg1aEUvdml2dlJwc2t5TmJBdm1EWk1oV1dCWlF2UlFTZ3ZyRmRO?=
 =?utf-8?B?a1JJOVFuR0NXYXdMdjNzOGdHY2VFNC9XaFViM3NZVDZKR3p5TGc4UzNmczRa?=
 =?utf-8?B?OGpaWGJVMkg3bUlOTDBRdy9ONUF1bmF1NVkxaE11ZnRUREJZRENtRFAxRUx3?=
 =?utf-8?B?cjVCbFFjWkVaTnRjYUFyYVhpR01xVWF6bWIrM0NKeG9MTXc4aUZnSlVKWWZL?=
 =?utf-8?B?MHhsaGhTVUc2UnRsYTc2Z3IxZDNWVXJ2ajFrWTlpRUIyL0hPbUJGb1BHamtK?=
 =?utf-8?B?Qml5U0wxK3NlU1IyczBIZDBqckVjTUdneUlZWVBUaDE1T29nc1VKV3NVS3Qr?=
 =?utf-8?B?c3BObWRLNllEN05rc1I2UzFaWGJ1eTlBYnhwNVRGcFlXay83QmNScm1uRnlX?=
 =?utf-8?B?NWc1V1h4akN4cDY3d0RNakdBeEZPUk02dU93QitVWTJOMkdScytaWVU5Q2Jl?=
 =?utf-8?B?Y0dzeTVkMm1LNmpKaVU4a1IyTWRtaTNOMUZGMXdVaXA4aEZGN3Fia0F6Qmxt?=
 =?utf-8?B?RWJ2ZHcwTnZRWTlVS2tNS1RIaEl6ZjY2amlJbWhPMHE3RjlRdTV1VGFaQXNr?=
 =?utf-8?B?Z3o4RnpIN2JLK3p4V3Vjd3FGWVhXNWVWSHJoWEozTkU1T0RZWnQ2Y3JCU2la?=
 =?utf-8?B?NlhyVVAwZEs4OUY0Y1dFVWhkQmNSKzh1T3lYTVk2dUJiZWFXdVljQnRscjRp?=
 =?utf-8?B?emNlUDEwSEZhZjU0Nmp5SmkxWTJjWTlITzRzWWJlS1dvVzBNRm9vK01LT3dE?=
 =?utf-8?B?Zi9ZcExEbmcwb083REJHczJhZFVzVUJ4ZDFjMFZUNHVNK1BlR1BkNjByMUhq?=
 =?utf-8?B?VTJNejNIRHVHdkFXZTRkZmtxNVJUM1FqMHdwM2h3aUMwYTlCbXJRZUEzbHlL?=
 =?utf-8?B?alZlWVhVME5XaUZpM2FISkM3YnpEMk1PWEVPenFjRkxtTHl5TVljaTQxeVJE?=
 =?utf-8?B?WmFoK21pSnVDbzlCYlpWcStSa084N3ZncEF0a2hZVURLWE9WNDlpdXBqeFdC?=
 =?utf-8?B?S1RST2YxcnU0c3RaeE0yMXlvTXFlNXVpK1hGWFc1R25GZ1hxRWIyMUxkMCtW?=
 =?utf-8?B?ZW9OUjFQYk14MGRjSWxxVkxqQkNLV0NYa2FpQjA5WXc5QXFRWGI2b1Z4MUVs?=
 =?utf-8?B?c2Y4YjkzZjRqeTJBc3dkZ0pKcGNyaUxaWWE5emxOU3djS0orWFVnQzErM1Jw?=
 =?utf-8?B?Wis2bytoa0ZiZ1pkZG9KN21hTjhMRHh3RGhEcDFadlVhL2NrdlZsYnF2TmVM?=
 =?utf-8?B?ZnRFWlJkTlZpcmFFTHo0UFJETlhkQStzSCtvcWhjYW94cGl4dFhLb29nV0JN?=
 =?utf-8?B?UkJQNjJMd3E0VGZoMWlCd1JoUThHTXl0Mzg5b3ZBVWFzYXV0SUpZQWlLLzJL?=
 =?utf-8?B?M3VZa0ZLS2hMbGgxd2wrcmNXUWI5V0VZNGUweDRPcS9rREVjK3FwOFNrQW95?=
 =?utf-8?B?SEVlcUxBNHREVlhpQ2FmT0RVbDgybjNQaXJ6TkpLNk1UVEFacXA3NWR5TmJo?=
 =?utf-8?B?VXozKy9PRmwzRXNSYmp4MFlxSkV0ZjBlTTE3MU1sQkUrZEJFY0ZPcndxT2dS?=
 =?utf-8?B?bWs5RldBOXp0WXlUUXh2d1lMKzFjcHc4VTdZTVhZNUwrSDcyUUladWJPSTBK?=
 =?utf-8?B?VWNyRGFSczl1OUhSSDhPWHIzQTlTVnpHNWtVWXFpeTZzOS9maHlzZnVyc2ND?=
 =?utf-8?B?Q2kzUWRma0tmUytVT0JPVFBIZk80S3ppOU0yd0RYU21WNTkzYVB0WVhCZGFN?=
 =?utf-8?B?dlFvR3RLZWg0WExEUnZicFJWVWI5WjVNd1hNNU5pNER5MzR6MzhSWW1sYk9V?=
 =?utf-8?B?NDhQMVZ0M1hHUGpUN1Uyai9zaVE1Q1ZuUE1KZEFBQlBGUE83cXYxajFMc2p4?=
 =?utf-8?Q?oNcA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a08515b-8fbf-40e9-6166-08dd6306a169
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 14:43:48.5060 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFcpKUFL9XPujpyDPdCPwq18qQ4SZlvM1fqVwCdLcjOWplrADg0rXCukvH3iJZ2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034
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

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbGV4IERl
dWNoZXIgPGFsZXhkZXVjaGVyQGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDEz
LCAyMDI1IDEwOjM4IEFNDQo+IFRvOiBaaGFuZywgSmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1k
LmNvbT4NCj4gQ2M6IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+
OyBhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IERldWNoZXIsIEFsZXhhbmRlciA8
QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47DQo+IEtpbSwgSm9uYXRoYW4gPEpvbmF0aGFuLktp
bUBhbWQuY29tPjsgWmh1LCBKaWFkb25nDQo+IDxKaWFkb25nLlpodUBhbWQuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDEvN10gZHJtL2FtZC9hbWRncHU6IFNpbXBsaWZ5IFNETUEgcmVzZXQg
bWVjaGFuaXNtIGJ5DQo+IHJlbW92aW5nIGR5bmFtaWMgY2FsbGJhY2tzDQo+DQo+IEkgdGhpbmsg
YXMgbG9uZyBhcyB0aGUgbG9ja2luZyBpcyBjb3JyZWN0LCB0aGUgc3JjIHNob3VsZG4ndCBtYXR0
ZXIuDQo+IFlvdSBqdXN0IG5lZWQgdG8gc3RvcCB0aGUga2VybmVsIHF1ZXVlcyAoYW5kIHNhdmUg
c3RhdGUpIGFuZCBldmljdCB0aGUNCj4gdXNlciBxdWV1ZXMgKHNpbmNlIEhXUyBpcyByZXNwb25z
aWJsZSBmb3Igc2F2aW5nIHRoZSBNUURzIG9mIHRoZQ0KPiBub24tZ3VpbHR5IHVzZXIgcXVldWVz
KS4gIElmIEtGRCBkZXRlY3RlZCB0aGUgaGFuZyAoZS5nLiwgcXVldWUNCj4gZXZpY3Rpb24gZmFp
bHMgd2hlbiBjYWxsZWQgZm9yIG1lbW9yeSBwcmVzc3VyZSwgZXRjLiksIHdlIGp1c3QgbmVlZCB0
bw0KPiBtYWtlIHN1cmUgdGhhdCBpdCdzIG9rIGZvciB0aGUgc2RtYSByZXNldCByb3V0aW5lIHRv
IGNhbGwgZXZpY3QgcXVldWVzDQo+IGFnYWluIGV2ZW4gaWYgaXQgd2FzIGFscmVhZHkgY2FsbGVk
IChwcmVzdW1hYmx5IGl0IHNob3VsZCBleGl0IGVhcmx5DQo+IHNpbmNlIHRoZSBxdWV1ZXMgYXJl
IGFscmVhZHkgZXZpY3RlZCkuICBJZiBLR0QgaW5pdGlhdGVzIHRoZSByZXNldCwgaXQNCj4gd2ls
bCBjYWxsIGludG8gS0ZEIHRvIGV2aWN0IHF1ZXVlcy4gIFdlIGp1c3QgbmVlZCB0byBtYWtlIHN1
cmUgdGhlDQo+IGV2aWN0IHF1ZXVlcyBmdW5jdGlvbiB3ZSBjYWxsIGp1c3QgZXZpY3RzIHRoZSBx
dWV1ZXMgYW5kIGRvZXNuJ3QgYWxzbw0KPiB0cnkgYW5kIHJlc2V0Lg0KDQpJZiB3ZSdyZSByZW1v
dmluZyB0aGUgc3JjIHBhcmFtZXRlciwgd2UgbmVlZCB0byBiZSBjYXJlZnVsIHdlIGRvbid0IGVu
ZCB1cCBpbiBhIGRvdWJsZSBsb2NrIHNjZW5hcmlvIGluIHRoZSBLRkQuDQppLmUuIGtnZCBpbml0
cyByZXNldCAtPiBrZmQgZGV0ZWN0cyBoYW5nIG9uIGtnZCByZXNldCB0cmlnZ2VyIGFuZCBjYWxs
cyBiYWNrIHRvIGtnZCAtPiBhbWRncHVfYW1ka2ZkX3N1c3BlbmQgZ2V0cyBjYWxsZWQgYWdhaW4g
YnV0IGlzIGJsb2NrZWQgb24gcHJldmlvdXMgc3VzcGVuZCBjYWxsIGZyb20gb3JpZ2luYWwga2dk
IHJlc2V0ICh3aGljaCBpcyBob2xkaW5nIGEgYnVuY2ggb2YgS0ZEIGxvY2tzKSB3aGlsZSBLRkQg
aXMgdHJ5aW5nIHRvIGNsZWFuIHVwIGltbWVkaWF0ZWx5Lg0KDQpTYWZlc3Qgd2F5IHRvIHJlbW92
ZSB0aGUgcGFyYW1ldGVyIHNlZW1zIGxpa2UgdG8gbW92ZSB0aGUgS0ZEIHN1c3BlbmQvcmVzdG9y
ZSBvdXRzaWRlIG9mIHRoZSBjb21tb24gY2FsbCBhbmQgaGF2ZSBLR0QgY2FsbCBzdXNwZW5kL3Jl
c3VtZSB3aGVuIGl0J3MgY2FsbGluZyB0aGUgY29tbW9uIGNhbGwgaXRzZWxmLg0KDQpKb24NCg0K
Pg0KPiBBbGV4DQo+DQo+IE9uIFdlZCwgTWFyIDEyLCAyMDI1IGF0IDU6MjTigK9BTSBaaGFuZywg
SmVzc2UoSmllKSA8SmVzc2UuWmhhbmdAYW1kLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBbQU1E
IE9mZmljaWFsIFVzZSBPbmx5IC0gQU1EIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KPiA+
DQo+ID4NCj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+IEZyb206IEtvZW5pZywgQ2hyaXN0aWFuIDxD
aHJpc3RpYW4uS29lbmlnQGFtZC5jb20+DQo+ID4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMiwg
MjAyNSA0OjM5IFBNDQo+ID4gVG86IFpoYW5nLCBKZXNzZShKaWUpIDxKZXNzZS5aaGFuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCj4gPiBDYzogRGV1Y2hlciwgQWxl
eGFuZGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgS2ltLCBKb25hdGhhbg0KPiA8Sm9u
YXRoYW4uS2ltQGFtZC5jb20+OyBaaHUsIEppYWRvbmcgPEppYWRvbmcuWmh1QGFtZC5jb20+DQo+
ID4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzddIGRybS9hbWQvYW1kZ3B1OiBTaW1wbGlmeSBTRE1B
IHJlc2V0IG1lY2hhbmlzbSBieQ0KPiByZW1vdmluZyBkeW5hbWljIGNhbGxiYWNrcw0KPiA+DQo+
ID4NCj4gPg0KPiA+IEFtIDEyLjAzLjI1IHVtIDA5OjE1IHNjaHJpZWIgWmhhbmcsIEplc3NlKEpp
ZSk6DQo+ID4NCj4gPiBbU05JUDkNCj4gPg0KPiA+IC0NCj4gPg0KPiA+ICsgICAgIGdmeF9yaW5n
LT5mdW5jcy0+c3RvcF9xdWV1ZShhZGV2LCBpbnN0YW5jZV9pZCk7DQo+ID4NCj4gPg0KPiA+DQo+
ID4gWWVhaCB0aGF0IHN0YXJ0cyB0byBsb29rIGdvb2QuIFF1ZXN0aW9uIGhlcmUgaXMgd2hvIGlz
IGNhbGxpbmcNCj4gYW1kZ3B1X3NkbWFfcmVzZXRfZW5naW5lKCk/DQo+ID4NCj4gPg0KPiA+DQo+
ID4gSWYgdGhpcyBjYWxsIGNvbWVzIGZyb20gZW5naW5lIHNwZWNpZmljIGNvZGUgd2UgbWlnaHQg
bm90IG5lZWQgdGhlDQo+IHN0YXJ0L3N0b3BfcXVldWUgY2FsbGJhY2tzIGFsbCB0b2dldGhlci4N
Cj4gPg0KPiA+DQo+ID4NCj4gPiAgICAgS2ZkIGFuZCBzZG1hIHY0L3Y1L3Y1XzIgd2lsbCBjYWxs
IGFtZGdwdV9zZG1hX3Jlc2V0X2VuZ2luZSwgYW5kDQo+IHN0YXJ0L3N0b3BfcXVldWUgY2FsbGJh
Y2tzIGFyZSBvbmx5IGltcGxlbWVudGVkIGluIHNkbWF2NC9zZG1hdjUvc2RtYTVfMi4NCj4gPg0K
PiA+DQo+ID4gV2h5IHdvdWxkIHRoZSBLRkQgY2FsbCB0aGlzIGFzIHdlbGw/IEJlY2F1c2UgaXQg
ZGV0ZWN0cyBhbiBpc3N1ZSB3aXRoIGEgU0RNQQ0KPiB1c2VyIHF1ZXVlICBJZiB5ZXMgSSB3b3Vs
ZCByYXRoZXIgc3VnZ2VzdCB0aGF0IHRoZSBLRkQgY2FsbHMgdGhlIHJlc2V0IGZ1bmN0aW9uIG9m
DQo+IHRoZSBwYWdpbmcgcXVldWUuDQo+ID4NCj4gPiBTaW5jZSB0aGlzIHJlc2V0IGZ1bmN0aW9u
IGlzIHNwZWNpZmljIHRvIHRoZSBTRE1BIEhXIGdlbmVyYXRpb24gYW55d2F5IHlvdSBkb24ndA0K
PiBuZWVkIHRob3NlIGV4dHJhIGZ1bmN0aW9ucyB0byBhYnN0cmFjdCBzdGFydGluZyBhbmQgc3Rv
cHBpbmcgb2YgdGhlIHF1ZXVlIGZvciBlYWNoDQo+IEhXIGdlbmVyYXRpb24uDQo+ID4NCj4gPiBr
ZmQgY2FuJ3QgY2FsbCByZXNldCBmdW5jdGlvbiBkaXJlY3RseSwgdW5sZXNzIHdlIGFkZCBhIHBh
cmFtZXRlciBzcmMgIHRvIGRpc3Rpbmd1aXNoDQo+IGtmZCBhbmQga2dkIGluIHJlc2V0IGZ1bmN0
aW9uLCBsaWtlIHRoaXM6DQo+ID4NCj4gPiBpbnQgKCpyZXNldCkoc3RydWN0IGFtZGdwdV9yaW5n
ICpyaW5nLCB1bnNpZ25lZCBpbnQgdm1pZCwgaW50IHNyYyApOw0KPiA+DQo+ID4gQXMgQWxleCBz
YWlkIGluIGFub3RoZXIgdGhyZWFkLA0KPiA+DQo+ID4gV2UgbmVlZCB0byBkaXN0aW5ndWlzaCAg
a2ZkIGFuZCBrZ2QgIGluIHJlc2V0Lg0KPiA+DQo+ID4gSWYga2ZkIHRyaWdnZXJzIGEgcmVzZXQs
IGtnZCBtdXN0IHNhdmUgaGVhbHRoeSBqb2JzIGFuZCByZWNvdmVyIGpvYnMgYWZ0ZXIgcmVzZXQu
DQo+ID4NCj4gPiBJZiBrZ2QgdHJpZ2dlcnMgYSByZXNldCwga2dkIG11c3QgYWJhbmRvbiBiYWQg
am9icyBhZnRlciByZXNldC4oYW5kIHBlcmhhcHMga2ZkDQo+IG5lZWRzIHRvIHNhdmUgaXRzIGhl
YWx0aHkgam9icyBmb3IgcmVjb3ZlcnkpLg0KPiA+DQo+ID4NCj4gPg0KPiA+IElmIHdlIGNhbiBh
ZGQgYSBwYXJhbWV0ZXIsIEkgYW0gb2sgZm9yIHRoYXQgc29sdXRpb24gdG9vLg0KPiA+DQo+ID4N
Cj4gPg0KPiA+IEFkZGl0aW9uYWxseToNCj4gPg0KPiA+IEZvciBzZG1hNi83LCB3aGVuIGEgcXVl
dWUgcmVzZXQgZmFpbHMsIHdlIG1heSBuZWVkIHRvIGZhbGwgYmFjayB0byBhbiBlbmdpbmUNCj4g
cmVzZXQgZm9yIGEgYXR0ZW1wdC4NCj4gPg0KPiA+DQo+ID4NCj4gPiBUaGFua3MNCj4gPg0KPiA+
IEplc3NlDQo+ID4NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gQ2hyaXN0aWFuLg0KPiA+DQo+ID4N
Cj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+IFRoYW5rcw0KPiA+DQo+ID4gSmVzc2UNCj4gPg0KPiA+
DQo+ID4NCj4gPiBSZWdhcmRzLA0KPiA+DQo+ID4gQ2hyaXN0aWFuLg0KPiA+DQo+ID4NCj4gPg0K
PiA+ICAgICAgIC8qIFBlcmZvcm0gdGhlIFNETUEgcmVzZXQgZm9yIHRoZSBzcGVjaWZpZWQgaW5z
dGFuY2UgKi8NCj4gPg0KPiA+ICAgICAgIHJldCA9IGFtZGdwdV9kcG1fcmVzZXRfc2RtYShhZGV2
LCAxIDw8IGluc3RhbmNlX2lkKTsNCj4gPg0KPiA+ICAgICAgIGlmIChyZXQpIHsNCj4gPg0KPiA+
IEBAIC01OTEsMTggKzU3Myw3IEBAIGludCBhbWRncHVfc2RtYV9yZXNldF9lbmdpbmUoc3RydWN0
IGFtZGdwdV9kZXZpY2UNCj4gKmFkZXYsIHVpbnQzMl90IGluc3RhbmNlX2lkLCBiDQo+ID4NCj4g
PiAgICAgICAgICAgICAgIGdvdG8gZXhpdDsNCj4gPg0KPiA+ICAgICAgIH0NCj4gPg0KPiA+DQo+
ID4NCj4gPiAtICAgICAvKiBJbnZva2UgYWxsIHJlZ2lzdGVyZWQgcG9zdF9yZXNldCBjYWxsYmFj
a3MgKi8NCj4gPg0KPiA+IC0gICAgIGxpc3RfZm9yX2VhY2hfZW50cnkoZnVuY3MsICZhZGV2LT5z
ZG1hLnJlc2V0X2NhbGxiYWNrX2xpc3QsIGxpc3QpIHsNCj4gPg0KPiA+IC0gICAgICAgICAgICAg
aWYgKGZ1bmNzLT5wb3N0X3Jlc2V0KSB7DQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
cmV0ID0gZnVuY3MtPnBvc3RfcmVzZXQoYWRldiwgaW5zdGFuY2VfaWQpOw0KPiA+DQo+ID4gLSAg
ICAgICAgICAgICAgICAgICAgIGlmIChyZXQpIHsNCj4gPg0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGRldl9lcnIoYWRldi0+ZGV2LA0KPiA+DQo+ID4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgImFmdGVyUmVzZXQgY2FsbGJhY2sgZmFpbGVkIGZvciBpbnN0YW5jZSAl
dTogJWRcbiIsDQo+ID4NCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGluc3RhbmNlX2lkLCByZXQpOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZ290byBleGl0Ow0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgIH0NCj4gPg0KPiA+
IC0gICAgICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgfQ0KPiA+DQo+ID4gKyAgICAgZ2Z4X3Jp
bmctPmZ1bmNzLT5zdGFydF9xdWV1ZShhZGV2LCBpbnN0YW5jZV9pZCk7DQo+ID4NCj4gPg0KPiA+
DQo+ID4gIGV4aXQ6DQo+ID4NCj4gPiAgICAgICAvKiBSZXN0YXJ0IHRoZSBzY2hlZHVsZXIncyB3
b3JrIHF1ZXVlIGZvciB0aGUgR0ZYIGFuZCBwYWdlIHJpbmdzDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92NF80XzIuYw0KPiA+DQo+ID4gYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9zZG1hX3Y0XzRfMi5jDQo+ID4NCj4gPiBpbmRleCBm
ZDM0ZGMxMzgwODEuLmMxZjdjY2ZmOWM0ZSAxMDA2NDQNCj4gPg0KPiA+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4gPg0KPiA+ICsrKyBiL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3NkbWFfdjRfNF8yLmMNCj4gPg0KPiA+IEBAIC0yMTMyLDYgKzIx
MzIsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGFtZGdwdV9yaW5nX2Z1bmNzDQo+IHNkbWFfdjRf
NF8yX3JpbmdfZnVuY3MgPSB7DQo+ID4NCj4gPiAgICAgICAuZW1pdF9yZWdfd2FpdCA9IHNkbWFf
djRfNF8yX3JpbmdfZW1pdF9yZWdfd2FpdCwNCj4gPg0KPiA+ICAgICAgIC5lbWl0X3JlZ193cml0
ZV9yZWdfd2FpdCA9IGFtZGdwdV9yaW5nX2VtaXRfcmVnX3dyaXRlX3JlZ193YWl0X2hlbHBlciwN
Cj4gPg0KPiA+ICAgICAgIC5yZXNldCA9IHNkbWFfdjRfNF8yX3Jlc2V0X3F1ZXVlLA0KPiA+DQo+
ID4gKyAgICAgLnN0b3BfcXVldWUgPSBzZG1hX3Y0XzRfMl9zdG9wX3F1ZXVlLA0KPiA+DQo+ID4g
KyAgICAgLnN0YXJ0X3F1ZXVlID0gc2RtYV92NF80XzJfcmVzdG9yZV9xdWV1ZSwNCj4gPg0KPiA+
ICAgICAgIC5pc19ndWlsdHkgPSBzZG1hX3Y0XzRfMl9yaW5nX2lzX2d1aWx0eSwgIH07DQo+ID4N
Cj4gPg0KPiA+DQo+ID4NCj4gPg0KPiA+DQo=

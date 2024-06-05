Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94C2C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E48C10E0BC;
	Wed,  5 Jun 2024 12:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5mnEaSTn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 768D210E0BC
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 12:54:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lgKX4kpRz4O2RjsWW6/5PaKDtUgrpg2ycUWkJiZEafSBV7D840+5fMTFMIT1yXjhOq/0gUBX0xdLfo7hJw4CZNEIALA3XCBReNE5SJu99JLmwzb7UIZYy6PbNt6DaAegTF3QCIvmkPKpS+5sZhQrwIszm0D80kIIJw4XAAzCjknZpGwFgwfCp6jXwuw1viiL5Y1VCDoOQeUh1U6XbqRHtaG9tG4wPvcxt7GPSpehkk+UEgn9SWBylRt7RilTEUYXo0qIHtrSdsRkZwOYCweC67AmfDjKuzPmEahTJF4JotZ6NPzMwXO37dbZi32u7tuJnPMXDCSbtiDFtxRbw+1z0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aoxj87h4tSUF4ipnSKB6z017mZqt1vs2FxsFCtPzfeM=;
 b=mRwiq1Rpn8kfWLVOkyV4eLAgWOvhgbfjm5UifYhMSpDVPo2uCgWIwBdkqqx6/Pp2MMeW8Wm2y5P2US1PnpEebcxqNXqYZYI7sAkIihTY5JY1KpcYtXMZ82wLnSDqBZFHBtRyK3QaEYgaig4z/49SE6rjrsQeY6I9vxDJ1yR931VBFuGTJSiUeJ+702Y+rV0M+z8jzs9WPBBXvNai+zwWoDNwXubfrn5UIQUuapIDtdSKjeST8oXOe6KR7zjSMYXrvmLMni+uW0bs0mdu2S3sXml/lq6NCqhKqTxZi+wy41Pgza5TxP4E113X3U6Ary24/UIx+P0jYsN2ofXCWYWqzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aoxj87h4tSUF4ipnSKB6z017mZqt1vs2FxsFCtPzfeM=;
 b=5mnEaSTnFJH9BhUNuHIiMUR1waEf5BPqV0GARW3IEe/MiAsE2OV9FpflPohRhXcF5QPVJe+TZVBJN5LTAkvAhRhiWR/CDVhyckpRyjPmq0zpXvUn/8Ltg2QGWdRZnwyyXFj89NwExEort1TmlwmGsWMoyWAW886XyA3PPuzJfE0=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SA1PR12MB6702.namprd12.prod.outlook.com (2603:10b6:806:252::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 12:54:39 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 12:54:39 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 00/18] Enhance amdgpu_firmware_request() to improve
 function flexibility
Thread-Topic: [PATCH 00/18] Enhance amdgpu_firmware_request() to improve
 function flexibility
Thread-Index: AQHatVdbKaU0WqPYkk+VakI0B4pymLG47AnQgAAeCQCAABVx4A==
Date: Wed, 5 Jun 2024 12:54:39 +0000
Message-ID: <PH7PR12MB599760408AAE8E776F61C4F882F92@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20240603014212.1969546-1-kevinyang.wang@amd.com>
 <PH7PR12MB5997A438EEF49A7BA1D6C23682F92@PH7PR12MB5997.namprd12.prod.outlook.com>
 <26da22e5-829b-4a27-9106-c9b3c89e42c1@amd.com>
In-Reply-To: <26da22e5-829b-4a27-9106-c9b3c89e42c1@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=3678e119-169f-497b-a53b-0d3cb805861e;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T12:37:16Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SA1PR12MB6702:EE_
x-ms-office365-filtering-correlation-id: a6f80a84-70b3-4944-738c-08dc855ea931
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?OGM0VWMxYUdKeTlFMmIxblhtemdNT3NHUWpxU3BvNnJPNHphK1dwV2k5MWh1?=
 =?utf-8?B?RkR6SE85c3Rvb0VTQU05Q0YrZU8rT1FXUVIzN1B0bWtBaWNvZkxvTWZzOEFC?=
 =?utf-8?B?aHVneC9jV3NxTUIwWk41OTI1TysxWE5VcEoyQTFvcFRkRFRIakhPOFVyOVFK?=
 =?utf-8?B?N1h3L2JTalpQbHVCZEpSZ29DdDkrUE1LdXBuNEZkTUMzbVN4ZTNmZXVFU2JO?=
 =?utf-8?B?SkkwSG9wVk5lMzZDZHFqWXhwK3ZsaUswT1pvQVFOOWdjUy9qbTJCak4vaWF6?=
 =?utf-8?B?TVQ3T2NoMW1mME96dGJQK2trWG53TmJGamk3eDVrSEUwNGxieHRKaVFDVmx2?=
 =?utf-8?B?dnhiQ1A4R2Z1MzR1NGV3SHRSSmRRT1NBMDZ6MW4yNGkvN25iSGFmUXg3enk3?=
 =?utf-8?B?VGdvRHVCMUtYQlJybXhKYllwOTVQaUFMb3UyN0dUejZodzltT2cveHRSR2Vi?=
 =?utf-8?B?ZlVYeEtueG04dWYrU3pkNFVwYTJBR3ExbzRFd200NE9Tc05NZWVWQm91NXcr?=
 =?utf-8?B?a25oTFhTTlNxMlpFcGNldGQrczNrWFdtellmeU5ZdkRCZTVnbW90aUJ3MTM4?=
 =?utf-8?B?d0F0NlFtelczSzJSaGlpT0t2RG1SdGFIeXNDWTBYVWEvSitxNm5OTHYyTm9z?=
 =?utf-8?B?WVBrQzh0V3BBbG94M2V1OGV3QVhSSnA5VEY3WFR2b0ZHVjk3dDJDdUxDYU5L?=
 =?utf-8?B?bmprVEpTUklDU2ljRFh4VVdsWVdtVFVyeGJmbmFXUE1ORlhNVTZwdERPb0R3?=
 =?utf-8?B?dE9mZWUzcjJidkNBdzdrN0VOMGkxYms5TGRwRW1rVXd5dTBlazJZZ1ptdVN1?=
 =?utf-8?B?TnhqRmlLRFNnYjN5akNMbXBSUGJxVllQODc5aGFoK2pxdTVKT3ZFeHJNTlMy?=
 =?utf-8?B?WUREOTNXUDI3WGd5bHpqa3ZhRHFYN0t1bHZ4QmZaZjNmT3FOR29JRFNtb29u?=
 =?utf-8?B?cEpWMUtOR0RIR08zWW4vbWh4bnRwUXhOR054bzJ6T0VvdzNzTFZQa3R2RVA0?=
 =?utf-8?B?bmRlbStMdlJub013L3ZWcVFSanhpcDlWcEFHNzQ1ZTNQd3JVKy9LMjhXQURQ?=
 =?utf-8?B?aHdoT3NCeUpVWWFFTm9nc0UwdWxLcDNNcG81MWcxZExIUEU5T0RrckpDN1li?=
 =?utf-8?B?K3NJRUdLOVBPcjZKcTJNOGwvSEdGblZCY0dFTkIwK21yZTQ4MzJtQ1A1Qlhy?=
 =?utf-8?B?OS80S2Vzd3NnMC93allPWGJ1UmF5V0FlOTB2d2VwUFVZbUNvQmJ0bVFkTTBS?=
 =?utf-8?B?OG95dC9QRzA5elpSTHRLTm12OHJ2UGk5ZEJLaGZqSjhIOEdBQ1FGdEUxZTI1?=
 =?utf-8?B?L2FPVXUvTXErcCtraW54SHRwZFFnWjR6SkRaWnNCNXN3UXVCM3F1Nm81Ukww?=
 =?utf-8?B?UzZvR0x5QkhnR2VQcUM2anB2WUM3alV5bVZENmY5eUZOZ3M4MXVMbEduMHow?=
 =?utf-8?B?d0xnM2VuUTBiTDNFSnQwSXQvWi9tQlU5d3J2M044cDhjVzNmSVp2YjhpOGc1?=
 =?utf-8?B?a1ZFMjhiZHhqRWZVZkNZQVlzUWdnMkdDWHBvbUVwRDZPZkdDaldMYXgwT20x?=
 =?utf-8?B?a01udm14MytiOGZwL3A2K2duMXpQTGpZVCt6UlBxcS9aMTFBTG1ub3N3Tkpv?=
 =?utf-8?B?cG1hOHJ6eVk2NURMRUt3b3I1MmMzT3ZLbUVhNG4vb3RUcTluY0JycCs2cnoz?=
 =?utf-8?B?Z1dHWHJVSnVxaTlyVEx4ck9uMnJzS3ZORURjekF5amVTM0Rxb3RHNlIrcjJt?=
 =?utf-8?B?NzFDdXcwZ3lQL2I4VjFpTlk5Qkx6elpvN1RQcHZNTUJTbmd6YWhlRzN3Tkox?=
 =?utf-8?B?bjRiUHlyZWtwUUx1SkpSUT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THc4ajUyVzgySTVuTngyOGd6YU9ydDZHS0IyS0VnSExvRGNpc2FmRXlkbTNV?=
 =?utf-8?B?K3lGaksyRU92bDFmUU8xenNkUTBlaDdzMzVueFRpdUtJVlg5WFlWRDgyaGZC?=
 =?utf-8?B?Qk1kRDhpUk1IaThOV2Q4ZEVyOHlMVWIvWlUzNENubFNacEw1R01IelFTeTU0?=
 =?utf-8?B?UnFkQkFDWjVZNEluaWNEMndFMHNpWFVSZ0JLRFA3Snp2UWtzTnJmdHU5eEIz?=
 =?utf-8?B?YVo5eUFYNDltUWhvYXo0WFpwTitIbEFIbjNaN1pSWEFZd21HYytCeS9wMEYx?=
 =?utf-8?B?eUNCZEtnUzB4ZEVKbEdaWU9XSjljcHE0K3V6ZytaVTlYNG8xak4wNUpHYk5D?=
 =?utf-8?B?UzhvWW5mczdEWWFVWnU4UEZ3cVF2VGVwTXY4WHMxWHRIUG9iWHpqeGVucmpk?=
 =?utf-8?B?Y0todmpHYk9zb2Zad3JQbWp2NThsVWZCckNmbUtCNExlR0F6S2F5Vk8vL1pT?=
 =?utf-8?B?WUZOT2pTQnBSUjVGZ3hhd3IwcnVEU081TEVnNDFUTTNQNDdIbDFkVEY0Tktp?=
 =?utf-8?B?MkVESXZqMjI2SGFOS3lLa3hvUDYrbjFCckVmZzlhTnQwZWhFWVVZUUJ2SnpX?=
 =?utf-8?B?SGxxUUFiQW5TbkY3UTJwbWRLUVpsNE1NNWRFeWNEMFlGcDF4UXFKSkVQUmJY?=
 =?utf-8?B?R1Rvc2I4eURtTW1WM3lPeUd3cTZZdy9rcHdRTDhzM2FnMzV4aTJrRGxOZnRL?=
 =?utf-8?B?YVRRUHRmUmRjZnhES3R5Y3BwMTFBVkVhMlByNXpUOHI2MFdVMDJoeUU1bzhx?=
 =?utf-8?B?V2QwS3pOc0pMZ0dwZWdYWVNDOUQrVVA0Z21DaU9sOWEyMnB2M21Rd0dzQzlQ?=
 =?utf-8?B?WHpLc0RvNURWOWYyOGJPV2RlOFIxRzZ0eG4wWGVEMVl2OUErWGdVYlJPSzI5?=
 =?utf-8?B?V1RYWEVkZTYxcXZzNlJHMnIrTTNTK0xsZnhEVjlMdGRyZStzOWwyVURxRTJU?=
 =?utf-8?B?QlMvMytLbTRaVTkwS3dhSTN5bTRLU0pMMGdVM2ZPMEE4Zm5TRDh0cXlObUNR?=
 =?utf-8?B?b2hkRDBHYkUzOG1lR244RTlOSS9Rd1J3R3pxN0xpTzdMbVhFYzcrWjVhUjZ2?=
 =?utf-8?B?QjZBRm5hNnJMUWhvTldTaUtkV0MwNVF0c3phelZOZFoxeFlTSXNocHRKckMv?=
 =?utf-8?B?ZmJlaGEwVGgxUkFyLzgzYTdKclhvNUhmTWtMUjYyeTFqR0hYK05oM29FYzE2?=
 =?utf-8?B?N3FRUkVFdWQzbkpsODhVNlJQMnErOEg0VTBLUFJGN29IN1JoaWZiUFdYc3Av?=
 =?utf-8?B?YWRXQWxWMFlZV1VVUjhYdW1iUVZ6dnJrRjBVVlk3Um82V1lQWGVTOVIrZUNN?=
 =?utf-8?B?bDJqZ2tRK20rcm42M3ZGdlBsUzRtWWozRThuQzdCYVJrREV4a3RCZkgyak9x?=
 =?utf-8?B?aFJiWXZ3MFZyazRlWlN6TGlrMjJZSmp6YUVmV2lqVEZ3ZkZlTVJxVWVFV2c3?=
 =?utf-8?B?ZW40UGRzUE0vWlFwa2Q0K0RJK2oySEd0SnJtZTY4OHVGZ1RDbmI0bjM2ZzJk?=
 =?utf-8?B?NlBOZTZ3cVJsdTNlQnkzOWVTaDkxZ3g0N054am5PdVNZa2dYYldIMVZMM0FD?=
 =?utf-8?B?Z0JRNmRKc1h1OUpEZ3JNUFFPeFMyVTZiSDdwMUovZDFjUC90TGl4OHNRTjB4?=
 =?utf-8?B?OEEzUmV2TCtJR05BdFdqVDgzdkN5V0Vndis3elpjRitja3VzZ2R6Q3dSMEl1?=
 =?utf-8?B?V0MzR2FJZWN5V0o0ZzFicTUvUk5ENmthQVBLZ2VxR1dCWUJEVk04dmUrRGpi?=
 =?utf-8?B?NTVlQmI0TkhhY2dDNnNqdDFONG5wTVVEUmtEMVJqTEdORlVkTWJ0bnhxNGlt?=
 =?utf-8?B?eWZmL054WG1oYkdjUm9OZnJWbHpGejc1bUhFSjFpSkFxRDFaRWswRVpCNVcv?=
 =?utf-8?B?OEs4cW9ScmxucWRmSzg5Q1QwUGI3U3llZnN3VmFma25mM00yQ0EwdGpzU3Rp?=
 =?utf-8?B?MDZqRElyRHVMaUdWdDNTWDNhaWdDMDVDRWxJTFhVcndNSVduMWx6amY4enJl?=
 =?utf-8?B?ZC92TzBSK1FyVVMyLzVIbjZKS0RXSjFNelN3MTVuL2NwNi9rK3lydlBJRXUx?=
 =?utf-8?B?cldJcklDblNCTmk0eWFWc241ck15NmVaYytRaHJ5SXlYbVQ0Y1JoVDdJLzMv?=
 =?utf-8?Q?jyHc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f80a84-70b3-4944-738c-08dc855ea931
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 12:54:39.1694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JjHlmslcQ6DH9EM1TYgQlKx/+6DA665Qn4IDvWgq0IShgMMxtJ824722QaThopIt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6702
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
Cg0KSGkgQ2hyaXMsDQoNCkkgaGF2ZSBjaGVja2VkIG15IGluYm94IGFuZCBkaWQgbm90IHNlZSB5
b3VyIGVtYWlsLg0KQ291bGQgeW91IHBsZWFzZSByZXNlbmQgaXQ/DQoNCkJlc3QgUmVnYXJkcywN
CktldmluDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBLb2VuaWcsIENocmlz
dGlhbiA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KU2VudDogV2VkbmVzZGF5LCBKdW5lIDUs
IDIwMjQgNzoyMSBQTQ0KVG86IFdhbmcsIFlhbmcoS2V2aW4pIDxLZXZpbllhbmcuV2FuZ0BhbWQu
Y29tPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcNCkNjOiBaaGFuZywgSGF3a2luZyA8
SGF3a2luZy5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5kZXIuRGV1
Y2hlckBhbWQuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAwMC8xOF0gRW5oYW5jZSBhbWRncHVf
ZmlybXdhcmVfcmVxdWVzdCgpIHRvIGltcHJvdmUgZnVuY3Rpb24gZmxleGliaWxpdHkNCg0KWW91
IGhhdmVuJ3QgYWRkcmVzc2VkIGFueSBvZiBteSBjb21tZW50cyBvbiBwYXRjaCAjMS4NCg0KUmVn
YXJkcywNCkNocmlzdGlhbi4NCg0KQW0gMDUuMDYuMjQgdW0gMTE6MzMgc2NocmllYiBXYW5nLCBZ
YW5nKEtldmluKToNCj4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0
cmlidXRpb24gT25seV0NCj4NCj4gUGluZy4uLg0KPg0KPiBCZXN0IFJlZ2FyZHMsDQo+IEtldmlu
DQo+DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGFtZC1nZnggPGFtZC1n
ZngtYm91bmNlc0BsaXN0cy5mcmVlZGVza3RvcC5vcmc+IE9uIEJlaGFsZiBPZiBZYW5nIFdhbmcN
Cj4gU2VudDogTW9uZGF5LCBKdW5lIDMsIDIwMjQgOTo0MiBBTQ0KPiBUbzogYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcNCj4gQ2M6IFpoYW5nLCBIYXdraW5nIDxIYXdraW5nLlpoYW5nQGFt
ZC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+DQo+
IFN1YmplY3Q6IFtQQVRDSCAwMC8xOF0gRW5oYW5jZSBhbWRncHVfZmlybXdhcmVfcmVxdWVzdCgp
IHRvIGltcHJvdmUgZnVuY3Rpb24gZmxleGliaWxpdHkNCj4NCj4gQWRkaW5nIHZhcmlhYmxlIHBh
cmFtZXRlciBzdXBwb3J0IHRvIGZ1bmN0aW9uIGFtZGdwdV9maXJtd2FyZV9yZXF1ZXN0KCkgdG8g
aW1wcm92ZSBmdW5jdGlvbiBmbGV4aWJpbGl0eS4NCj4NCj4gWWFuZyBXYW5nICgxOCk6DQo+ICAg
IGRybS9hbWRncHU6IGVuaGFuY2UgYW1kZ3B1X3Vjb2RlX3JlcXVlc3QoKSBmdW5jdGlvbiBmbGV4
aWJpbGl0eQ0KPiAgICBkcm0vYW1kZ3B1OiByZWZpbmUgZ3B1X2luZm8gZmlybXdhcmUgbG9hZGlu
Zw0KPiAgICBkcm0vYW1kZ3B1OiByZWZpbmUgaXNwIGZpcm13YXJlIGxvYWRpbmcNCj4gICAgZHJt
L2FtZGdwdTogcmVmaW5lIG1lcyBmaXJtd2FyZSBsb2FkaW5nDQo+ICAgIGRybS9hbWRncHU6IHJl
ZmluZSBwc3AgZmlybXdhcmUgbG9hZGluZw0KPiAgICBkcm0vYW1kZ3B1OiByZWZpbmUgc2RtYSBm
aXJtd2FyZSBsb2FkaW5nDQo+ICAgIGRybS9hbWRncHU6IHJlZmluZSBpbXUgZmlybXdhcmUgbG9h
ZGluZw0KPiAgICBkcm0vYW1kZ3B1OiByZWZpbmUgcG1mdy9zbXUgZmlybXdhcmUgbG9hZGluZw0K
PiAgICBkcm0vYW1kZ3B1OiByZWZpbmUgZ21jIGZpcm13YXJlIGxvYWRpbmcNCj4gICAgZHJtL2Ft
ZGdwdTogcmVmaW5lIHZjbiBmaXJtd2FyZSBsb2FkaW5nDQo+ICAgIGRybS9hbWRncHU6IHJlZmlu
ZSB2cGUgZmlybXdhcmUgbG9hZGluZw0KPiAgICBkcm0vYW1kZ3B1OiByZWZpbmUgZ2Z4NiBmaXJt
d2FyZSBsb2FkaW5nDQo+ICAgIGRybS9hbWRncHU6IHJlZmluZSBnZng3IGZpcm13YXJlIGxvYWRp
bmcNCj4gICAgZHJtL2FtZGdwdTogcmVmaW5lIGdmeDggZmlybXdhcmUgbG9hZGluZw0KPiAgICBk
cm0vYW1kZ3B1OiByZWZpbmUgZ2Z4OSBmaXJtd2FyZSBsb2FkaW5nDQo+ICAgIGRybS9hbWRncHU6
IHJlZmluZSBnZngxMCBmaXJtd2FyZSBsb2FkaW5nDQo+ICAgIGRybS9hbWRncHU6IHJlZmluZSBn
ZngxMSBmaXJtd2FyZSBsb2FkaW5nDQo+ICAgIGRybS9hbWRncHU6IHJlZmluZSBnZngxMiBmaXJt
d2FyZSBsb2FkaW5nDQo+DQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rl
dmljZS5jICAgIHwgIDkgKystDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2lzcC5jICAgICAgIHwgIDQgKy0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfbWVzLmMgICAgICAgfCAgNiArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9wc3AuYyAgICAgICB8IDI2ICsrLS0tLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS9hbWRncHVfc2RtYS5jICAgICAgfCAgOCArLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9hbWRncHVfdWNvZGUuYyAgICAgfCAzMCArKysrKy0tLQ0KPiAgIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91Y29kZS5oICAgICB8ICAzICstDQo+ICAgZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jICAgICAgIHwgMTQgKystLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92cGUuYyAgICAgICB8ICA2ICstDQo+ICAgZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvY2lrX3NkbWEuYyAgICAgICAgIHwgMTEgKy0tDQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ2Z4X3YxMF8wLmMgICAgICAgIHwgMjUgKysrKy0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92MTFfMC5jICAgICAgICB8IDI2
ICsrKystLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjEyXzAuYyAgICAg
ICAgfCAyMiArKystLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nZnhfdjZfMC5j
ICAgICAgICAgfCAxOSArKystLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92
N18wLmMgICAgICAgICB8IDI3ICsrKystLS0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvZ2Z4X3Y4XzAuYyAgICAgICAgIHwgNjkgKysrKysrKysrLS0tLS0tLS0tLQ0KPiAgIGRyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV8wLmMgICAgICAgICB8IDQ1ICsrKysrKy0tLS0t
LQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dmeF92OV80XzMuYyAgICAgICB8IDEx
ICsrLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192Nl8wLmMgICAgICAgICB8
IDE0ICsrLS0NCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9nbWNfdjdfMC5jICAgICAg
ICAgfCAgNyArLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OF8wLmMgICAg
ICAgICB8ICA2ICstDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaW11X3YxMV8wLmMg
ICAgICAgIHwgMTAgKystDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvaW11X3YxMl8w
LmMgICAgICAgIHwgMTAgKystDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2RtYV92
Ml80LmMgICAgICAgIHwgMTEgKy0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvc2Rt
YV92M18wLmMgICAgICAgIHwgMTEgKy0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9sZWdh
Y3ktZHBtL3NpX2RwbS5jICAgIHwgIDggKy0tDQo+ICAgLi4uL2dwdS9kcm0vYW1kL3BtL3N3c211
L3NtdTExL3NtdV92MTFfMC5jICAgIHwgIDYgKy0NCj4gICAuLi4vZ3B1L2RybS9hbWQvcG0vc3dz
bXUvc211MTMvc211X3YxM18wLmMgICAgfCAgNiArLQ0KPiAgIC4uLi9kcm0vYW1kL3BtL3N3c211
L3NtdTEzL3NtdV92MTNfMF82X3BwdC5jICB8ICA2ICstDQo+ICAgLi4uL2dwdS9kcm0vYW1kL3Bt
L3N3c211L3NtdTE0L3NtdV92MTRfMC5jICAgIHwgIDYgKy0NCj4gICAzMCBmaWxlcyBjaGFuZ2Vk
LCAyMDUgaW5zZXJ0aW9ucygrKSwgMjU3IGRlbGV0aW9ucygtKQ0KPg0KPiAtLQ0KPiAyLjM0LjEN
Cj4NCg0K

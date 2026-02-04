Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155EFE95372
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 10:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E5A10E5A9;
	Wed,  4 Feb 2026 10:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ctnRx06L";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C76110E095
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 10:05:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LMbwRpVVH1fHanhRZZ4wGeDPmXitm3by82TPLR/YiSiJ4bU7gWB2j7P6wS8CZYqhK2KQLaZ4f02z/qSvYpJ3hbWqMnbatuuNx3XI7Dt6XerGQOAzQidd/2rrXGTHzc548V+fyfuMXt6cNDPduYpphc9ZyLjcRhqoxZFxf1V8gs/Cy483pFDJko1FxrqgL2hItx0kLzKsygsfONLa2xsWRjFLw9cRHfPAv/zAVTeSvT0JZzSIjWDz0VW8raOtijz+Z0SGtoeTYgw3/N7A+lMjV5npjQ75idTUr2EmdF32xo8Or6eiPIHAGJCYkbtnivL1DfTPNuPYDH1dvUpvEvyn0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vVeSuqZD5jtBhUA2d1IllIxcSiy8vMEzj9UAs6hOros=;
 b=MGzQ2/3vk4a44gOlEoSLR0Zbwbk0TQDcYbdGIsswLTjUdVswFsRmPXtgl2LT5GJaIaqnNvZ/Nn6+T6GM1LtFqgeF/S57qd2omIcqdAq2U7QrbRp8bdvphTmk1JL3Xrp4lA6S8/lHvZLVeYTLLUOJTGBglSv3ELmNys3X2sWleL9pT0TjnkaVjLXg6ZNajBXALVsouUMjivYI+m46LFOmxXlvQuzEVLGLfF9jjZPTpqERRdlL6MJx/mL0B8stmOlWvrnG/72oE1fUXPF3jo0eh/e3XUyaZ/Wx8jGOende2MOHGBVmYF8if9508JcfrIpZz0xwF+WavtNCSDMs7yB8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vVeSuqZD5jtBhUA2d1IllIxcSiy8vMEzj9UAs6hOros=;
 b=ctnRx06L9gGnCV/k95xIdW4lWzZuwDVTz8DXYcrwtp3QRqQLDDEHPG0y6chbzE3auZHNHjZ7rPpSBdE3VBOdUQ68atGEs/EqXFrh2A9NqPQ652vT8P8JhlnUQbcRN3sBfgrLj5BkdsfBL76Gtkk2CmyqynPpNxaiHCkV3lCxaQs=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Wed, 4 Feb
 2026 10:05:28 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 10:05:27 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Kamal, Asad" <Asad.Kamal@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Zhang, Morris" <Shiwu.Zhang@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf
 check
Thread-Topic: [PATCH v2] drm/amd/pm: Remove redundant and incorrect multi-vf
 check
Thread-Index: AQHcla/uEOswMrSKi0aea7YQZlMTvrVyRquAgAAICAA=
Date: Wed, 4 Feb 2026 10:05:27 +0000
Message-ID: <PH7PR12MB59970022C8B598A0111B4F478298A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260204082547.3799740-1-asad.kamal@amd.com>
 <13ffc589-243b-41f6-b219-9136fbcaf09d@amd.com>
In-Reply-To: <13ffc589-243b-41f6-b219-9136fbcaf09d@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-04T10:00:05.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH2PR12MB9541:EE_
x-ms-office365-filtering-correlation-id: 794db093-debe-4c01-9e55-08de63d4ebf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eTlnMHhkVnBKVE11N0hoSkhYYkJmVVFaTUpMZFJMM0ZBWGsramZEL3BmWVhl?=
 =?utf-8?B?YmJUZFF4cHQ0MnlkdndOUmQ3QUp2alVOMFJZWWp5RFRyZ2dpUmRrRXU2TVo2?=
 =?utf-8?B?bDYvMFAxeG5UdnR2TDE2cERybGwybWRkMzlIR2JheG1TZzFIMnJsZzg4WlBt?=
 =?utf-8?B?OGlVOHVOQUxZMlIzVlNTRlFLcmp6NUdQbnQrYXgrUlJWc1RJdXRtb1lpcW8v?=
 =?utf-8?B?SVE1eEtpbG15M0U0emJJODEya3hGcGJ3Y1BuOWpOaWY2bDZRbXZCajNLUDZB?=
 =?utf-8?B?SnNuekc1WjhrTUVDUGdTeHJjT1g5SHZzazdoc1hjYzhLV3hHTythbytidXdZ?=
 =?utf-8?B?TkVBc01VVisxYnZ4QzBjVDZraDFMTTMzb1krcUhDUHNHWG92VFA3UVVKbWhn?=
 =?utf-8?B?V2VNQnVHT1RkYUFLNkZHS2FWV1FEWTZ3WEhFb0w0Y3JnMFF6M2RoK3Npa2Nm?=
 =?utf-8?B?TlB3cnRNNzc3YWU4U0xJaWpTM1VNM0ZJazVWY0p3SmRSSEt6SWdJa1N6VGF1?=
 =?utf-8?B?emJRdDh5TzJ2eW5XU2NwMVhZeXhNODJoV2dsOEdkeFJ4dTFDYmV1WmF1eE10?=
 =?utf-8?B?emZrMXlzRnoxcEVJb3pHeUpoVVBJMEVQWnhmWHliaEhlSGRsc0NlaEVzcU9v?=
 =?utf-8?B?ZGh2NmlkZUFrTWxUd0xpTXprN3U4TDRJUzdzdmVaRDlBTFVWUmxLdFpvMDdF?=
 =?utf-8?B?Rk4zb2dRd1ZOazdOUFRQcDJ6SlpnSVljcEFVbEQvSHVqSGUyekY5VVRuU0FG?=
 =?utf-8?B?V2pDRlNSWXF0bGNWRmdvY05zQW5Kd2YvOG5tMlphYy9IVUNRNU96OW9VckVS?=
 =?utf-8?B?alZhMWF6TWZZTXNvRWwybEJrdHBabWpRRjlNTW0zbWVsNmlLbS9iaWkvSUw5?=
 =?utf-8?B?V1hzd3ZQcUdWSHpvMm9rV1gyL1RPT2tZd3FmWVB0U08rRXhGQjkybjZHTzBX?=
 =?utf-8?B?ZDZSa2RqdTFFZlEvNGc5U1ZYYmdydjBpN3R5Tm9NeUd4MkFpVjVOSmhVNUNQ?=
 =?utf-8?B?R05mRUhvV04vZXUwWE1aSUFSMnRMMWZ3cm95ZDJqdHJaZ3JFRk5kS3B3RXha?=
 =?utf-8?B?R2xzMDJoYmNISU9vM1NjNk9wWEVmQzN3VGVnZDJBUEk3TXJGMUIyUWNVSFR6?=
 =?utf-8?B?ajllSkVXNi92cjc5dS9YYzBGVDVDNzkwcmpvaEx2eWhCa0FQQUkwQXhsQ3A5?=
 =?utf-8?B?d1JCRFdPTkV5YWtQTENIWHV0emRPNkxXby9MZDI0NldXbWtuSHprM3JwNnBw?=
 =?utf-8?B?ajNyODZuWWpWYVdrZXBteFRjZ243Y3U5eUs5NTlBanY3ZGRKODhiempoM2R3?=
 =?utf-8?B?ejBhNzRVNFBMOHo5bW1ISzFMaGlJbDc3Z095OEQwZ3VrWkRZajE4bzlIRFhE?=
 =?utf-8?B?UWFRMFhWYm16dzg4UklhUGROOUh4KzZMRkk3Q0F3cmtvUk5BQ3lEakxETDB1?=
 =?utf-8?B?L3NlSGNMa1FJU0g2dkJYVHphVENyaXltM1R4ZzBSazNabDNKdll6QjhNNllK?=
 =?utf-8?B?bHQ0c1hMVnB0Y2VuYUpJNHllZEZDMnkxMnlod3hYU1BzTDRIY2JUV2NKNHB1?=
 =?utf-8?B?cGwvQittUG0wV1R2UmxYQWFTaElFNHFha0U2WXU1NkVuZHFaTWliaHNzYkd3?=
 =?utf-8?B?RnVHZUpKYTdMcm5EcXhRWFZXT3VvbWN5alp5M1kySVpieG9taTF3K25pQVJL?=
 =?utf-8?B?T3V5WVVIUDQ5QWdoSWhQNy94dkF5MmE3V2pLSllhdm14QytaU09UTTh5ckZs?=
 =?utf-8?B?QWxveUZPRnlZcmVQOHVveGZOZklxcVM5YW4xdGxtRzBkK1hxajZtTFQrZU80?=
 =?utf-8?B?VmVzOUdnYk90c0d2RFI0aTYybkV6N2NVQkZDSmFFUzIwUGpJQUdPR2VxT3A4?=
 =?utf-8?B?QnhjaXZZTjEydit1eDdqMldLZWowSDgvckRVT2tkNTdwL3I1MUZyN3hTTy9x?=
 =?utf-8?B?MnV3N3JBVmMyeTY3cElRZU5LQytMVU83SEdXRHZNTWJ6a3BLNkxLZnVYeXRM?=
 =?utf-8?B?MmVES1VqbGUrVHVqZUlGVzAwYy9reXlvT3AzMEUzLytNVW80TjcxNWNFZEZr?=
 =?utf-8?B?OTlhOVpaSFV0L3BnZzRSR0NhcmlFekxNODhQRDVvK3hxc09uNXVXQUs5Z0I3?=
 =?utf-8?B?NFBFT2NBSnN5amN1c1lpc1JYNlkxYkpoUThhME1tai9hTVg5UXVsMUpVbzcv?=
 =?utf-8?Q?gMZ85LqwSyIsan++hcbTty8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlpZQjZTZUxXNFh1MWxYWldnWURLRGNpZXZnUDlBTzVrRGMyUWhiWlBvd2lH?=
 =?utf-8?B?OVFheGs2YlhBeXJQK1ZUTjdZNXBGdEc2SFlIREovOXhmaXlMaEtrVXNvMzRT?=
 =?utf-8?B?VjV4TEE2eGlVY3BvK1kvN1lrdnE5UDl2NnA5dy94dDNXOTloenVlMXpKWGUw?=
 =?utf-8?B?VDRGR0hIaWh3ZUQ2ZWQxeSt5ZEVHUTdQQ0lKcVNhZE9kOTJCMWNDSjh6RDh6?=
 =?utf-8?B?STc0anM0U2twZ3dNbjgraWxOSnZlbFRrYzExajQrbEJuYmJMYXFLc0lreFE1?=
 =?utf-8?B?ZUdIeCtxbUdPdUFiU21oeXZPVHp6bU04UlVwbEI1aFk3M2pEUUlvVDN2dkt3?=
 =?utf-8?B?ckYvbmdjdXNUTHJjYjVnTVpkNTRFdXJoblJnU0xGSVlFWEY1QWx0SnNWM1Bu?=
 =?utf-8?B?cE9taS9yR3hTRlhUcjN1emtBUXhXeVFWby9nZ1ovWjdKdVlONDViRk85TFlq?=
 =?utf-8?B?dE5OTGIvZmVMOGdPU1orMWV5VWZ3SzFDS3R5OHRNVzVtTHlTR295L2RsUEpx?=
 =?utf-8?B?QVg1N0tkZERlandFQWFVZVBXZkdyK2FYdGVoVE9FdXA5K3RVeWVEdVNTUm9K?=
 =?utf-8?B?RGEwSjJ4OG9ta1l1bjVQMWFnQlhsLzdEcCt4bWJ0WVhtRjFya2RzTE8wNWo4?=
 =?utf-8?B?M0pGYW8zdWxUK0pidnd0T25XN2FiRDlieW05eS84S1k0Y1BNUXlLK0FMdGla?=
 =?utf-8?B?dDRmTHJISE5sT0pDNlFJVUVGd25LRExKNjU5RjdBWWl2MU5iRVh5YzB6VVVx?=
 =?utf-8?B?b0xHaXBEc2ZkSHdtOGRlTGE2NFMrN05rcXYvNXZjWUJzbDZkYndhS3VXQW5S?=
 =?utf-8?B?YVZjZUVtNnY2cTBRbXRkVlNUTEUzbnF1ZCtOeDlEVjBReVVJMWFLc0dhLy9u?=
 =?utf-8?B?NDJ4cWRmMm9zbXEwUW5xVjRzTG9hOTdaQmpsZTc1bVN1dDB1bXhRVWN2RVBy?=
 =?utf-8?B?aksyVXloVHY4ajRjeGozYWMyR1pNKzNDck5IMGNsR2pJOGl2UTZhbVBrWjNo?=
 =?utf-8?B?dk11UVhKM1pzY2F2eEFFbCtLL0hTY2o1ajZ4bG1pTEpFV2JGWDVxcVIzZldX?=
 =?utf-8?B?ZHpGQTlyWG8zaUFtZ3I0YnN0TFdwTFhqMFA5cXp0RmVVS0o1VjZkaXdMWnU1?=
 =?utf-8?B?T0JUazE4SUZRMUFLYnRsTmp0a0dsVHR0MUFRUFE2ejVDdllBalQ4YmhaZE5n?=
 =?utf-8?B?M1Vxek52amxyNjJMd0UzVlE1RkpIVytkR25ZdXlmR1JnTmJPMUZKQVExWGgz?=
 =?utf-8?B?RWRia2pSd2djY2R3cnNIb3hQVUEvS1pJNkpnckJyKzBHWXRRU0JkbG81eFpw?=
 =?utf-8?B?em5lS3k2T2pMcjVoN1lzS3poNVQ1UGhheDZPTHVIUWltMmtDR3dxZEQ4YmlN?=
 =?utf-8?B?MVFUVkFkK0luVHpIa2trcjJPcDkrRDhCNUZWdGdRSm85QjJ2cEFjLzAyOTdw?=
 =?utf-8?B?aGEvSTNHbWd5UzV5Ym92endYV2ZlKytocE9OT0pmTGQrQ3pqWThrVHJPQ0lH?=
 =?utf-8?B?MjBKLzF6d2l0Q1krY0N0enE4RjBwVkxMdzd5SzdvMU1nNUdFOEFGVlBZWEJx?=
 =?utf-8?B?UXpRNG8vaWk3WmhmNGdEQndsWkVGUWJFT3lvc3I4QmRJbkoyTjJRUUp2Q0dt?=
 =?utf-8?B?Rk9xdm00WnY1ZWt0TkNLTjFQaTFXZDYwU3g0QnZXUXlBUUMzQmtBdUFNUlFF?=
 =?utf-8?B?ZnM2OE15UW5tWTlXRFFGTEM0dWI1SGVtazR5VTMvRUxjYkdNdXFkSld3YzZI?=
 =?utf-8?B?MEZGNGMrWTBHemlqYUMzRzAyYlFON2lVQzVnY2RHQlM1ZWhqOHM0T1ZEcG1J?=
 =?utf-8?B?eHR0Q0xSdWIxeXpVSXdZUjdranloMU9GUlRTSmxqbkVXTUdGYnRRZ2QwZExO?=
 =?utf-8?B?QjN3Y082LzBIME5sZndra1RqcHBwb2p2eTFxR1NCRkRkQjZ4VGNVWHY1RkQx?=
 =?utf-8?B?enNsLzlFenBoVjU0b1dkOGlTNkp4ejhGN1Uzc2FsQUZ5KzZON2dsRjl3WFhx?=
 =?utf-8?B?TytFK3lkNmI4OUZWbFk3SGw3a2RDWDFhUVNycDFKcWxXVCsyZVVrTW5TTUlJ?=
 =?utf-8?B?dm9halFVTnU2NWhDOW5KTEVmeEJVZ29iVndpSHd4dFd3QkwxU2ZGU3VoR1VF?=
 =?utf-8?B?Q3BLTEZ0MkszdWZpQWE4Sjc5Q0Nrb1Y0RENHRlU3MnNpQnpJclNMYkpTd2hJ?=
 =?utf-8?B?T3JuQU8raGVsME90YW5VVTZWcnNLcWRaVDJXNStSVUdsOFhIRTRkdm1LQWoz?=
 =?utf-8?B?RGtjOGFCb1BQYTUzOG5mQUV4bWswQXJzTHFNMVNnaTIvNyswelVNUEFrS1Rp?=
 =?utf-8?Q?f4geQlSYCmtBzkOelh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 794db093-debe-4c01-9e55-08de63d4ebf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 10:05:27.5669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drtg/IWR6Xt3EHImSvH3rHbqGzOj4k0zna2aI08RNFDL/rk+zq71s9Ri2cjHK6MB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541
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
Cg0KPiBSZW1vdmUgcmVkdW5kYW50IGFuZCBpbmNvcnJlY3QgbXVsdGktdmYgY2hlY2sgZm9yIHBw
IGNsb2NrIHNldHRpbmcsIGFzDQo+IHRoZSBjb2RlIHBhdGggd2lsbCBuZXZlciBiZSB0YWtlbi4g
TWFzayBjaGVjayB0YWtlIGNhcmUgb2Ygc2FtZS4NCg0KSSBzdXNwZWN0IHRoZXJlIG1pZ2h0IGJl
IGEgbWlzdW5kZXJzdGFuZGluZyBvZiB0aGUgY29kZSBsb2dpYyBoZXJlLiBUaGlzIGlzIG5vdCBy
ZWR1bmRhbnQgY29kZS4NCkN1cnJlbnRseSwgQU1ER1BVIGRvZXMgbm90IHN1cHBvcnQgdGhlIG11
bHRpLXZmIGNhc2UsIHNvIG5vIHN5c2ZzIG5vZGUgd2lsbCBiZSBjcmVhdGVkIGZvciBpdC4NCkhv
d2V2ZXIsIGluIG9uZS12ZiBtb2RlLCBmb3Igc2VjdXJpdHkgcmVhc29ucywgc2V0dGluZyBmcmVx
dWVuY3kgaW5mb3JtYXRpb24gZnJvbSB0aGUgdmYgc2lkZSBpcyBub3QgYWxsb3dlZC4NClRoZXJl
Zm9yZSwgdGhlIC5zdG9yZSBpbnRlcmZhY2UgaXMgcmVtb3ZlZCBhbmQgdGhlIG5vZGUgcGVybWlz
c2lvbnMgYXJlIGNvbmZpZ3VyZWQgYXMgcmVhZC1vbmx5Lg0KSW4gY29uY2x1c2lvbiwgdGhpcyBz
ZWdtZW50IG9mIGNvZGUgc2VydmVzIGEgY2xlYXIgcHVycG9zZSBhbmQgaXMgYnkgbm8gbWVhbnMg
cmVkdW5kYW50Lg0KDQpCZXN0IFJlZ2FyZHMsDQpLZXZpbg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IExhemFyLCBMaWpvIDxMaWpvLkxhemFyQGFtZC5jb20+DQpTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDQsIDIwMjYgNTozMSBQTQ0KVG86IEthbWFsLCBBc2FkIDxBc2FkLkth
bWFsQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KQ2M6IFpoYW5nLCBI
YXdraW5nIDxIYXdraW5nLlpoYW5nQGFtZC5jb20+OyBNYSwgTGUgPExlLk1hQGFtZC5jb20+OyBa
aGFuZywgTW9ycmlzIDxTaGl3dS5aaGFuZ0BhbWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyIDxB
bGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgV2FuZywgWWFuZyhLZXZpbikgPEtldmluWWFuZy5X
YW5nQGFtZC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBkcm0vYW1kL3BtOiBSZW1vdmUg
cmVkdW5kYW50IGFuZCBpbmNvcnJlY3QgbXVsdGktdmYgY2hlY2sNCg0KDQoNCk9uIDA0LUZlYi0y
NiAxOjU1IFBNLCBBc2FkIEthbWFsIHdyb3RlOg0KPiBSZW1vdmUgcmVkdW5kYW50IGFuZCBpbmNv
cnJlY3QgbXVsdGktdmYgY2hlY2sgZm9yIHBwIGNsb2NrIHNldHRpbmcsIGFzDQo+IHRoZSBjb2Rl
IHBhdGggd2lsbCBuZXZlciBiZSB0YWtlbi4gTWFzayBjaGVjayB0YWtlIGNhcmUgb2Ygc2FtZS4N
Cj4NCj4gdjI6IFVwZGF0ZSBwYXRjaCB0aXRsZSwgUmVtb3ZlIHRoZSBjaGVjayAoS2V2aW4pDQo+
DQo+IEZpeGVzOiAxNjZhM2M3MzVjOTUgKCJkcm0vYW1kL3BtOiBjZW50cmFsaXplIGFsbCBwcF9k
cG1feHh4IGF0dHJpYnV0ZQ0KPiBub2RlcyB1cGRhdGUgY2IiKQ0KPg0KPiBTaWduZWQtb2ZmLWJ5
OiBBc2FkIEthbWFsIDxhc2FkLmthbWFsQGFtZC5jb20+DQoNCllvdSBtYXkgZHJvcCBhbnkgcmVk
dW5kYW50IG11bHRpdmYgY2hlY2sgaW4gb3RoZXIgYXR0cl91cGRhdGUgY2FsbHMgYWxzby4NCg0K
VGhhbmtzLA0KTGlqbw0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1
X3BtLmMgfCA2IC0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1X3BtLmMNCj4gaW5kZXggMDc2NDFjOTQxM2QyLi44
MWJlZjVjNWFhZTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvcG0vYW1kZ3B1
X3BtLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9wbS9hbWRncHVfcG0uYw0KPiBAQCAt
MjA1NywxMiArMjA1Nyw2IEBAIHN0YXRpYyBpbnQgcHBfZHBtX2Nsa19kZWZhdWx0X2F0dHJfdXBk
YXRlKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCBzdHJ1Y3QgYW1kDQo+ICAgICAgICAgICAg
ICAgYnJlYWs7DQo+ICAgICAgIH0NCj4NCj4gLSAgICAgLyogc2V0dGluZyBzaG91bGQgbm90IGJl
IGFsbG93ZWQgZnJvbSBWRiBpZiBub3QgaW4gb25lIFZGIG1vZGUgKi8NCj4gLSAgICAgaWYgKGFt
ZGdwdV9zcmlvdl92ZihhZGV2KSAmJiBhbWRncHVfc3Jpb3ZfaXNfcHBfb25lX3ZmKGFkZXYpKSB7
DQo+IC0gICAgICAgICAgICAgZGV2X2F0dHItPmF0dHIubW9kZSAmPSB+U19JV1VHTzsNCj4gLSAg
ICAgICAgICAgICBkZXZfYXR0ci0+c3RvcmUgPSBOVUxMOw0KPiAtICAgICB9DQo+IC0NCj4gICAg
ICAgcmV0dXJuIDA7DQo+ICAgfQ0KPg0KDQo=

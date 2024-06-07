Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEA3C27C53
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jun 2024 14:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C42FA10E010;
	Fri,  7 Jun 2024 14:43:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QocKtyh8";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7957010E010
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jun 2024 14:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FT5RXGdDF8VkBJugKA6lKmtlNypkhIeQo/XED5rlDhvtoPKP+etEKIego8p9GrlfzAy/zb+aWZMWV3prLdHBntRaxiO1d1ATfFcn3YqhWCQt+zt4vsmErdxbxEa2Wpp2qzVSzZSYLoeQNFXIGN3LhOmRHI9L8iIdIXU2ACqYXxPHLz/ltG/MLNlx0hTsEzzhEfvsE9EYavdf9aYGmmhSeznb8ipPgBxIvUtV7hy7X/1F5dVp521yg6BfNOkLQrxxH2GTfDuVsZiamMzIyTGgoBT3EKeO2csl0zzsOZ6NlTW8ul2jq8dVbGSDY3CpKVAI8KJ/Ey6Lal5FG/NCK6L39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0misXaaH3mfoLdH+EOVo9/L20PxYOvh1kHNWpaQ9JyY=;
 b=N4rZqRGW8SO7LFslSThkXTQXfPWHh+6V7mhx3ZTVx4Iov8YPODuG31EC9mbdmZ8VrJpUhVuersGXIoab7v7TDCLKZZtoUcsB5CMOL5GvQv7YdGr/84SXHXLR0hiJ2GE7kAmi+eYnoluSQ4nLdPvkWUWwpz5uevZpGqz50WS9ZOuDKGMQD+4jl8s1Aybj6zLSvdlaFqBZim3r4mFkMvjjVxq0LfOHKcW3+kFdcl+qYnYqaUDnnSKg9jXwm8G66MiGIkhLS0cUtYyjuA5wpEWD/z2BEt4uhkirOz12rQAKSlyiUievlxiiL4/ZUzHlDO20Yets1zw7wax467vWDY25IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0misXaaH3mfoLdH+EOVo9/L20PxYOvh1kHNWpaQ9JyY=;
 b=QocKtyh88KTqHIkliY0QW5F/c0eoijblqm4gaAT0FBIUjurX44JFfeQo2L6vZoSA71EI57dlFAFqMsU33qyOq1T4gSj2kJy+JhA190cPG8FqEvW9GoU6uelj8g+hHwDMSNTy4fAFEg85MQ1nBE4NM7gclTmdHHUQc1gYkfxemgM=
Received: from DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) by
 MN2PR12MB4173.namprd12.prod.outlook.com (2603:10b6:208:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 14:43:33 +0000
Received: from DM4PR12MB6445.namprd12.prod.outlook.com
 ([fe80::e74f:f5db:9c45:9a24]) by DM4PR12MB6445.namprd12.prod.outlook.com
 ([fe80::e74f:f5db:9c45:9a24%6]) with mapi id 15.20.7633.021; Fri, 7 Jun 2024
 14:43:33 +0000
From: "Joshi, Mukul" <Mukul.Joshi@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Bhardwaj, Rajneesh"
 <Rajneesh.Bhardwaj@amd.com>, "Yang, Philip" <Philip.Yang@amd.com>
Subject: RE: [PATCH] drm/ttm: Add cgroup memory accounting for GTT memory
Thread-Topic: [PATCH] drm/ttm: Add cgroup memory accounting for GTT memory
Thread-Index: AQHauEb9kmrSaPG+vEa4oJhS212kN7G752EAgAB16TA=
Date: Fri, 7 Jun 2024 14:43:32 +0000
Message-ID: <DM4PR12MB64450D65311D55DF3ABABE0FEEFB2@DM4PR12MB6445.namprd12.prod.outlook.com>
References: <20240606192233.2836986-1-mukul.joshi@amd.com>
 <c2ce5317-a817-48d8-9fa7-ae6dcfbdaf3b@amd.com>
In-Reply-To: <c2ce5317-a817-48d8-9fa7-ae6dcfbdaf3b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=6468cec4-2436-4de3-a4f1-1768dbfc4c56;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-07T14:28:10Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6445:EE_|MN2PR12MB4173:EE_
x-ms-office365-filtering-correlation-id: 12ba2d28-e98b-4d35-916f-08dc87003474
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?aTFveitodFpUME5BL2l5T0RNRmhZcEs1Y1hpZ2pwMjZSblp1QytuVnVhMkty?=
 =?utf-8?B?ZlEzamJpUVhIYkFZUFBaZzBJaGdMRHZXdEJRVGRxcjdMWGJ4c3l3REsrMmxh?=
 =?utf-8?B?ckpqaVRGSkswdHU3MWNncGZ4TENsQndqY2pvTzhiRjFGTWxRZ1g5Z24yWjNj?=
 =?utf-8?B?NHZtNlNzZ3hMdlZVNm43KzVnNDc2dUtYcFYzTlV3TTgvUTdhQnFQbnA1R3BV?=
 =?utf-8?B?SDZaUWowTHBqdURUeXE5bjFyNE9SVmcvRmF3ZDRYWnB4RytYNXFBQkNobjds?=
 =?utf-8?B?U0tMSXFxMU84ZFV1TTRwWGl4ajJ3UTNNTkNIUldObXhSWFBKRk5BSmFybUxH?=
 =?utf-8?B?cXdlWDNocUx3dFFsbVl2eStRSXEwTllLL3E3ZndZRzh5R1NHK21ZSzk2WHhu?=
 =?utf-8?B?S1A0MkJtOWNiYzN6OGVXVlNZTk8vTnZROGxka2VBaXRQSzlnVVRycHVMemFR?=
 =?utf-8?B?YlEra2NrTTFraDNqRHRkcDlXNkRhUjE1VW1RekRTK25xSWlwNElGQmJESGpq?=
 =?utf-8?B?M20vcWVYdHJPSUlhR3prSy91c2ZuV2NTeE5iT2Y5MmZBeVpxeEFFL09DaUFB?=
 =?utf-8?B?aVo2MlRnNFpHckJBNzRCZURzQlNqSmplZk1JVlNzc0pSYzJzQmdaQ2VKNG4y?=
 =?utf-8?B?WFFvZU43L1RQVkpPWkdWUjAwZ2hTajJlbS81QmxBbEsxbWs1NUhQbnR1dUtx?=
 =?utf-8?B?ME1NOHVWZ3lsMmsrRXd0cXQyaUw2djBub2xOTk8zT3hvVUhZWmxjeVZPb1Zt?=
 =?utf-8?B?OWhvU3lWK0VSUHR3ZzI5SEFxb3N1STh1QzYvQzR4WnNWWmxPNGFZVktmSzRS?=
 =?utf-8?B?QyswTEd6bU9WRFdlejdHWFVxT0tTNU9ZNms3OEJzeWF1UVY1Y3FoUHR6TG0w?=
 =?utf-8?B?Z2d0cjVCL0xlOS9ZSzR1RHR5eks5dFBnTGlmNy9sSGNNRDRHMXkvRVRKR0Uv?=
 =?utf-8?B?VFF5cEs1YllMaExyUW0zRWhqUEd3MGlGL05CSXBYY0FJRlFBNkVCWjNOSitq?=
 =?utf-8?B?RzFzMHVhSDl0dTE4bHZJdEpoK01JVWtYTXZWTXVjS2VBZTU4RVd6OWxBcCtR?=
 =?utf-8?B?UmNTYXhGdHJTTHZzVHF4cnExRkFKNGIrajVtQ08wVzVYZVFVS1NxemUvclIx?=
 =?utf-8?B?U1BKb00zRnZKc2FCd3hocnRqd2RocG50RFBSTERnenBWZXFmbFY1QkFWd0sw?=
 =?utf-8?B?UHVkTnd6NkVaMXRPVUlORHNDNVlTeTg5S0t2U1I4bmxieUxINlFwQ2F1Qkp4?=
 =?utf-8?B?MWRDaGZYUHFuWnFzN200Z1ladGJ3VjFDdVVMdTh4cU9rcityb0ZjQndQdGdV?=
 =?utf-8?B?UHJmOG8vNEZmRVE1NVFGa2tvWVZFNURxQ2crWmxqaFYxcFhRTHFmTHY5YUJx?=
 =?utf-8?B?YktYZU1pNks4SWM0RzNaZVc4ZXk0YklnVm9LQnd5N3ZLMk11UFQ0ejh0SnVK?=
 =?utf-8?B?bWQ4bDdCckIyZ2RBdTVaUC9BMDZobUpEcHVySVNuRml6K1JuQm0xS202MVJS?=
 =?utf-8?B?TU9Nc1Zuc2cyZG9hb0ljVWEyazd5MTZlUWthb3dKNDd6R1h1N0YvbUZxSTZl?=
 =?utf-8?B?cEhHTlJXOUJIMVBnaVJtWE9Dd1JydkplTThoMzFlMWdBaUxEaHdBdXFGV1Vz?=
 =?utf-8?B?bERaSkJabFFlalM2RXY0ZHJETFora2hZdUFyTllFSGNuRVZEUHVCdWNBK2hz?=
 =?utf-8?B?YlU0c0x6Tng3N2VpY3BiNUNpTG5ueSt3TU91bXhuRGwvdFhyYTNmTTJNU21v?=
 =?utf-8?B?K0ZxbTI1RWc3cVVlVzVOT01iODB3VGV1ZURFSjRBRjhtMVo4N21hcmRWUlBW?=
 =?utf-8?Q?2F9Brkmb1sdV+bwI/H59jlqzQKlOovM5SM514=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aURPUEExdmZFcFp2YlBSVnQzMkZWckg0K1VsVjFGTDg4bThoMGpHc3BNZkw2?=
 =?utf-8?B?RlRyeVpqZTFiTld1Z3MwVkgxUGpUTDBCWmZtTHJQTE1MeWdWclQxbFoxd0Nv?=
 =?utf-8?B?VzR6aGlDUWxGdDhZMlZhbDZqNThXQXFzZ1FxREFxM0hKSXNIUHVlcVhMMTJr?=
 =?utf-8?B?SjJoQzlVOHNKUW12L1o1YUp6eDg0S0ROR0QvSzhVVWV3SGVZbnY2bzV2d3VP?=
 =?utf-8?B?S2Z2VDN0QXBGWDFPaWo3SmhuVXBUMWMwdDNTUHBzOS9vMm1NOVNmdGQxNkU3?=
 =?utf-8?B?ME5WbW0vRzVIdXI0QmlyS3VGcXZPVG02eEdmYTEvcEo4K216cEhDTExUTXpG?=
 =?utf-8?B?Tk1tQmd0RjR5azA3bnR0TGdveUVkL0ZJK1NHS1BaTUV0c240TFFVL3MyVmdx?=
 =?utf-8?B?R3ZZeGJaUFhmN29MenFnMzBTam9HYWw1aUM4TTlEd3JnK29jSGVVUkZyZit1?=
 =?utf-8?B?cGJHQ0ZDTDRLRnh0THM3Y01jcnA0aExaT3pQRUx4LzE3clNXdEdCWm9lUEFV?=
 =?utf-8?B?ODFqbEMxSHBEZWpORFlRMVV5ZnJxb3pOWllwNDRoSEhsTW5LT1lRQ3FZaEFS?=
 =?utf-8?B?R1FhNURVLzZWVDdzUHg3d01YckFjMkpCSEZDU0JhblcrZVFGUUp2ZkNzOVJo?=
 =?utf-8?B?TUtpVW9xdVVHWDVIVmttY3pFeVB1S1Z1U2Z6Mm9xVFROeTNKUmhkb3NzT2d5?=
 =?utf-8?B?T01HNWU0Z3BqUzdnLzV1a29EUEE1VWRZSy9qTEx4cW5EeDUvVGg3STF0UUUx?=
 =?utf-8?B?bFNCbWZXSTJKdUh4MzA1eGxPUGZUNXJFWU5keWFNMUQ5WkxjTURnMmJ3L0d6?=
 =?utf-8?B?UlBIMmwrKzMwOThjYTBiL3hhaGRqbmE5TXlYeTdjdklKL3BjVWovR210RHpO?=
 =?utf-8?B?Y3lxQ3dqbmMzSUFGV3NlZFEyV3ZpdXkzaGlVcmVlY3FEbDIyUWJac1UxS3R6?=
 =?utf-8?B?amtsUlVJRmFXT2tEWXorMW9vQnhUMHRkYnp1VG1jZDNsbFNMRWh2SCtEd0tT?=
 =?utf-8?B?SEtxZHpjTTFxM080YWc5ZlBidUxpWjFhU3RBSWN0Mys4TmVobVVvTjlyd0lV?=
 =?utf-8?B?ZTA3dGdTNUcwYnlvSCtSeTk5K09PRDg0eEgyb1hSR2Y4UWdHRkxNKzYrSUYz?=
 =?utf-8?B?bENzbGNLemdUREFjL2V0SGt0eUZweXViR052K0FaMU5KT2xEVEhmdmVNeDFY?=
 =?utf-8?B?aEdLQ2sxcEZzWE5iRklMdWZnOWxxcEUzMFBXY2lvdFFTSTZpTElEcDAzT3Mr?=
 =?utf-8?B?Q3NhWkpuTGFZRGJQaUZEZWlES0x3Y1lpQnd1ZkV6Y25JSWw0Qzh2OUZMbmtW?=
 =?utf-8?B?cjFJT2ljZGVPaC8zWlYxamp1dThabjNiR1hjQ0FvRmJSSHVKeGk1RVFQRndQ?=
 =?utf-8?B?bmVWL1JQVjFxU1NPM2R6QmtUcXFaSDV4aDBKZ0NFTjZOd1RFWVJaNTR2TXM2?=
 =?utf-8?B?MGJ1RnlJRktwQVVVVmd0SEE1bm5NUXY0MFBYYXIyVCtHWW5xSHMrSmVteG1s?=
 =?utf-8?B?eW5jdXQyQW5VRFRVTkpadzBqOWEreHZ6RGtPTkloQk9mOVpibkt0dEJjNTNk?=
 =?utf-8?B?c0J4TTVnZDVRbmhMMjFBOVdNZ3VwTW5IRi9xNDFLZTcrdThWclBMcFJkQjZh?=
 =?utf-8?B?Z1dGa0djaXVmY1dUZm1CRjNpRHQ1cXAzNzdvV2l2SS9RMDFTVWxUTmNSdTBl?=
 =?utf-8?B?T3AwOGxFK01Bc3Zic3dZUVNTUVc1NUdodDJwbWxPbGpQaUdyRjdoL09DVG5r?=
 =?utf-8?B?SStCUDZTdUcyTi9rSWhrYUUvUTBjUldBbnVlUW84Y1RlRC94R2VoY0YyTHpR?=
 =?utf-8?B?R0kzRkh0b1l6Sm9yaHRIbU9rS2ZSd2dTWFdSekxKNmNXdUczK3JZb0NUM1FS?=
 =?utf-8?B?UEw4dGRxNzNDcWtrUHZvcnFHUjJsNmhRL1NPdG81N0VRYm9vcmg4UFNtQ243?=
 =?utf-8?B?azVjMzZJRHlyREQxbjhlemd3RmUzcTBLelRUV0ZRMUV3Vm8vNGlYZUtrSkhl?=
 =?utf-8?B?dDhxYlVwWlpOTWNQTjZya2VBVlptRWdEQ2NJaDB4Yk5oNmRuOExwNGFNUHR5?=
 =?utf-8?B?Mk8vOGxKSjJvUS9HZFhUTXR2czcyMi9PcGxUWWQ0eWk5cGFpbVczbWRMdWFN?=
 =?utf-8?Q?G21c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ba2d28-e98b-4d35-916f-08dc87003474
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 14:43:32.9001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMqdYk38VzozTsMI7pmlp57ZwOPhiaXp+q7LoB6KRh1SevmVoDd5SOmrMqZu3KV/EBbHoN4112vqPV55DC5vVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4173
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
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLb2VuaWcsIENocmlzdGlh
biA8Q2hyaXN0aWFuLktvZW5pZ0BhbWQuY29tPg0KPiBTZW50OiBGcmlkYXksIEp1bmUgNywgMjAy
NCAzOjI2IEFNDQo+IFRvOiBKb3NoaSwgTXVrdWwgPE11a3VsLkpvc2hpQGFtZC5jb20+OyBhbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBDYzogS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5L
dWVobGluZ0BhbWQuY29tPjsgQmhhcmR3YWosIFJham5lZXNoDQo+IDxSYWpuZWVzaC5CaGFyZHdh
akBhbWQuY29tPjsgWWFuZywgUGhpbGlwIDxQaGlsaXAuWWFuZ0BhbWQuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIXSBkcm0vdHRtOiBBZGQgY2dyb3VwIG1lbW9yeSBhY2NvdW50aW5nIGZvciBH
VFQNCj4gbWVtb3J5DQo+DQo+IEFtIDA2LjA2LjI0IHVtIDIxOjIyIHNjaHJpZWIgTXVrdWwgSm9z
aGk6DQo+ID4gTWFrZSBzdXJlIHdlIGRvIG5vdCBvdmVyZmxvdyB0aGUgbWVtb3J5IGxpbWl0cyBz
ZXQgZm9yIGEgY2dyb3VwIHdoZW4NCj4gPiBkb2luZyBHVFQgbWVtb3J5IGFsbG9jYXRpb25zLg0K
Pg0KPiBOQUssIFRoYXQncyBpbnRlbnRpb25hbGx5IG5vdCBkb25lIGxpa2UgdGhhdC4NCj4NCj4g
UGxlYXNlIHNlZSB0aGUgY2dyb3VwIGRpc2N1c3Npb24gb24gbWVtb3J5IG1hbmFnZW1lbnQgb24g
dGhlIHB1YmxpYw0KPiBtYWlsaW5nIGxpc3QuDQo+DQpDYW4geW91IHBsZWFzZSBwb2ludCB1cyB0
byB0aGF0IGRpc2N1c3Npb24/DQoNClRoYW5rcywNCk11a3VsDQoNCj4gUmVnYXJkcywNCj4gQ2hy
aXN0aWFuLg0KPg0KPiA+DQo+ID4gU3VnZ2VzdGVkLWJ5OiBQaGlsaXAgWWFuZyA8cGhpbGlwLnlh
bmdAYW1kLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNdWt1bCBKb3NoaSA8bXVrdWwuam9zaGlA
YW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bvb2wuYyB8
IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90dG0vdHRtX3Bvb2wuYw0K
PiA+IGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcG9vbC5jIGluZGV4IDZlMWZkNjk4NWZmYy4u
NTllMWFjY2RlZjA4DQo+ID4gMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL3R0bS90
dG1fcG9vbC5jDQo+ID4gKysrIGIvZHJpdmVycy9ncHUvZHJtL3R0bS90dG1fcG9vbC5jDQo+ID4g
QEAgLTkxLDcgKzkxLDcgQEAgc3RhdGljIHN0cnVjdCBwYWdlICp0dG1fcG9vbF9hbGxvY19wYWdl
KHN0cnVjdA0KPiB0dG1fcG9vbCAqcG9vbCwgZ2ZwX3QgZ2ZwX2ZsYWdzLA0KPiA+ICAgICAgKi8N
Cj4gPiAgICAgaWYgKG9yZGVyKQ0KPiA+ICAgICAgICAgICAgIGdmcF9mbGFncyB8PSBfX0dGUF9O
T01FTUFMTE9DIHwgX19HRlBfTk9SRVRSWSB8DQo+IF9fR0ZQX05PV0FSTiB8DQo+ID4gLSAgICAg
ICAgICAgICAgICAgICBfX0dGUF9LU1dBUERfUkVDTEFJTTsNCj4gPiArICAgICAgICAgICAgICAg
ICAgIF9fR0ZQX0tTV0FQRF9SRUNMQUlNIHwgX19HRlBfQUNDT1VOVDsNCj4gPg0KPiA+ICAgICBp
ZiAoIXBvb2wtPnVzZV9kbWFfYWxsb2MpIHsNCj4gPiAgICAgICAgICAgICBwID0gYWxsb2NfcGFn
ZXNfbm9kZShwb29sLT5uaWQsIGdmcF9mbGFncywgb3JkZXIpOw0KDQo=

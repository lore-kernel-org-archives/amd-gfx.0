Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EB0C7115B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Aug 2024 01:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7BB10E171;
	Thu, 29 Aug 2024 01:26:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iVutM+Jf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 965D910E171
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Aug 2024 01:26:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPMT7B77n06AayhBUlYuDAkf1o+4l4AzUrjLps6qEswg0SzydDOEFsdDa3Z6Z4cg2QqNx/HQ/WJMWIORr2EkiyR2j5FyDJEucmumbCJfZeZsREC+0cEc6WWWmXpLpDbW9LUZk7W5XdnX+WG5IjAaXRNlt6ucCtrGMhykyu2jpAxJMQ85ijoKzUkdRsO2/2hQh3j6ha/8RvZBjsz/nMHwvbMKNZj5Wqy3X1vV+F6YctQQlxWPmjkEbO+Wg0y+CL2QhIC/2B+SVng3d/F7NaudmyW+PKsNMUIWgfvcG9RU9x56OSR4UVro5bCtOJfIZYvelCWH5letAQykyCTF+IKDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8WGrgg9yGsI1rIaZteS+OGjzdnBLMHBtOsjH3RdnNE=;
 b=xgZv6hcFbMf4exZy0S3DFrhhRU1mDmSafHZWF8Yiiw1xjU+bQNzsxe4sqZ5a36mYH5PcRhY9FON5tAcgcsKs+YZWMxALO66RBcn+PDu0zYnnrkn0d6non8L7DaqCEvwSi5q47IYLVUXtsNL6E04VKujtxN7vbsYDOSf8mHQYXrnEW/l6r79UcjuAl23qOPySjjosEPr+ZawPJ4vvBHS2GGN6LGZnHaB/+8mEIcsZsl8rV1H5kztzQUM05XoKGsIa01+oybnOx7ItEdcmoHhs6JjQ/c61//DmV5zxflHP7y3RLw3v13Vr0WeCR8PkAwClAmaiPJuWxzB3VRQlvxSMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8WGrgg9yGsI1rIaZteS+OGjzdnBLMHBtOsjH3RdnNE=;
 b=iVutM+Jf3lxlxVuh4xAOdxwzVxfze51sOmyioU/XYxXrFyQiIv1igvQvqh7vP02f9aQS7QymTU8L69vTD1c+ddQmTTipTwox1CFnKjWf0UIdP8zT3+exomIThMUlP9n+tBkZUBESdMzT2Jk4rCuDtync9/xJtB/r84NFWx3nzDg=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Thu, 29 Aug
 2024 01:26:30 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 01:26:30 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: =?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: revert "use CPU for page table update if SDMA
 is unavailable"
Thread-Topic: [PATCH] drm/amdgpu: revert "use CPU for page table update if
 SDMA is unavailable"
Thread-Index: AQHa+IuzMr8lBvMLtkmS+j2OlhV5VrI9c6gg
Date: Thu, 29 Aug 2024 01:26:30 +0000
Message-ID: <CY5PR12MB636957CC558C25912EF42EE8C1962@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20240827141619.2553-1-christian.koenig@amd.com>
In-Reply-To: <20240827141619.2553-1-christian.koenig@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=8519383c-cd6a-497d-a076-98fed944b26a;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-08-29T01:25:46Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|SJ2PR12MB8034:EE_
x-ms-office365-filtering-correlation-id: 76835a81-08a6-4d1f-c489-08dcc7c99c27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WGh6NXIrdkNKVXFITmVPTS9zWjl2ejIzT0NRMXY4aFFOaFUyQjc5cnpteVRV?=
 =?utf-8?B?c3VySjRSdE5kLzU2M0VzMFFBWTdMQUJmbE9oOXN3MjAzdWdqVzFlSFRmZ0da?=
 =?utf-8?B?M0F2NGlZcXdiNU1VU1l3MG5ZeVFvYzl3L2JLWGthdHhnU0kxS0IzL1FzV0JH?=
 =?utf-8?B?MFRCR2JFcXI1cmQ5ZVFVVTVrYXZlT2M2ODExbWo2VTVuZGxybDlnanZqNkF5?=
 =?utf-8?B?dHkxdGFjV2tHMTdWQmVZRUxyK2IzWFAwMWtDU2dYeXlDRHNOcDYvWHNmRkFp?=
 =?utf-8?B?M1duL2xWVERWV2x2SE0zM3lNNFl1a2NTaWRERytPK21saG5sTUh0aXBYaHlT?=
 =?utf-8?B?SUswOW8yeU8xRGE5dlNncDlSMDc2NXpBUGtCQ1VsblhpbnBkaGhwVGtJSkwx?=
 =?utf-8?B?Vm1pakZUdW9CM0d5emJ4alNsaXNnOWhERkUxcitiSTdRM3BCYWg2Y2tvdWZl?=
 =?utf-8?B?WC9zS1Qzb0Eyb2VSaGFPQ0RCdG0xU1BoTVBsWTltM0tRN2xPNUJPWnlwc2Fy?=
 =?utf-8?B?enBCZHdkWHMxVS9pa2xjZm1CVlhPWEI2aC9oYnpzY25ZVFNWcjdYUmFReXNC?=
 =?utf-8?B?VHJVTTFBUjlQNWtJaVU1NEtIUVZzNlZZNlJSdWdlUlR1MmdnOVNIazFmeFlk?=
 =?utf-8?B?azkyVHZYU2FtMThZaU5VVVlkMmVKRXZWRER0WXErU3JNRGNiekJrNlZuZ2Z6?=
 =?utf-8?B?aGp6MFVFZ01KZ0JVNTk4Q05qaE5DU0REc3lqd2JXK1FQOHdwdlRVblVGMk9i?=
 =?utf-8?B?aEhQd2QyaVlFRTRpbmhFc3JpWWpOZjlDSFFWZURkYWxnRkJWTXFFZHIyeVp2?=
 =?utf-8?B?VGh2QXpJZlRTbUIyNDg5YnQyTFRjekRzZmptQnpaRU4rTjZ6bGpNNVhwOHdz?=
 =?utf-8?B?cGI1UFVRTWUyWVd3VDN0N1lMZ0cvSnRBazdlZ2lZR053MGd2aWg2QTVpQUxp?=
 =?utf-8?B?Q2w0Q0xpTHhiVm9IY1BjcndIZEltOVBQVFl3YWtidDMvTit4RDI3cHNlZlZC?=
 =?utf-8?B?SW13Smt4T2JGVHRudkh3RWNvV3ZDR09IeEdWbEF4UHhEYXVsT3o0TFNkbkNT?=
 =?utf-8?B?cFlGR0ZZRzJTOU9kNDR0TzdiOS9hTk52amR1elNCMU5VeGJqTTRwR3YwWnlm?=
 =?utf-8?B?TkRZSVVudXB6MUJvQTU5YUo1WWRwdHRzaFRIanZpYlh4SzhmT2UvWGZsYVdJ?=
 =?utf-8?B?TjhuckFGaDllZ29qdFRHTzg5ZkNFUnpiRXRCVW1LTjJOdTBhWGdCemVFNEdM?=
 =?utf-8?B?OTJBcXJib2djb25kQkZvdXBiNnNnd2hMTlIzRFJodkZwTmZ5THFwYVZocFBm?=
 =?utf-8?B?dSsweXAxZWp2akdyZTJtL1pGV1ZhYTI2Wlc1Ly9vTTY1V2laa2NHYSsxMlRL?=
 =?utf-8?B?cTZsenhqU1ExVTFyNmtSUGpZQ1ppNUlqWGEzM1dPZ2I1MDFnNWE0d0Q5N1Jl?=
 =?utf-8?B?ZDBGQW1RTjZvNTc4T0pOYldtOUs4aVllL05DUGtidU14ZG05YUtJUjBxZ1RB?=
 =?utf-8?B?NlhkRUdoRTZybGlZdGx6blROcllGMTFzUW55ZXoxWHI4YjhKOXU1WEVOUzRv?=
 =?utf-8?B?RCtDbFpuYktVYnIxM0hKR0hKWm1HZTM1Q2Jna2JJeEtpdFpld0hEclhrRXVZ?=
 =?utf-8?B?T1Jkam82am5QNWhXMXUzRVZBUTRqVHR3Z3FwSjBrdGszdGRxc0RpOGY4N2Zp?=
 =?utf-8?B?WnpWZTN4Q2xoa3JMRnBadis0enhFUzhyZnFiSlZkQkozY0NGa0JkN0krVVZH?=
 =?utf-8?B?cmZqSWppbFV2UlhxMVhrUjF0SUxhR3ZiY3BERXM1ZnJzREdwR2VDZVBidFpK?=
 =?utf-8?B?ZzRoMG52ekJ6QjVFVEJZZFV3Z3lhOXpwbTc3QlN3OXpiTHVUbW1ZOGxVZFlD?=
 =?utf-8?B?bXZKbUlhWWEydW50MzBrb0pFSkVUdUlqaUJFUzBMQWNzWkE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2xrelI0ZWs0RkdUbVhjT1RpeG1CdmVhQWxxNU9OVGFnMzIxR0gyTVNvUVox?=
 =?utf-8?B?TmlWYVQ0a09Kd1pKUXJvNTg4OER6WTFjSGlMcHQweUxoc0luaXZJQkY4RlE3?=
 =?utf-8?B?Z1BJZFBJWFlLODdlb3NEdXhCTllwMnc5cE42WmphM2NlWHNLNnp3aWhiWC9H?=
 =?utf-8?B?ZzM5cmJoVm1qZEZPNVJhS21pRHJSNTNRQytxcElUcDJTbFlzOTJFL2JkQzFk?=
 =?utf-8?B?OXU0YXZPeERHNHhWR1IzL2lPM2dWMHJkVmQ5b3JoY1BkU1UxUVFySFhyOWEv?=
 =?utf-8?B?ak9ZNDVBM2ROakZqdi9HMjZFUTFtekttV2NnZHlHSTc1dTk2UUZmcHd2WXZM?=
 =?utf-8?B?VThpM01ndStPblptWFVweVdLc3JZOFRwaXNCZCtWdzBabE1oVFZTeWdwaW1m?=
 =?utf-8?B?WEViTWRWaHg4RFBwVk0zVHRVcTBzUlN2QnE1MDJ2bFF2VXVOcDZ3WGh4V0Jp?=
 =?utf-8?B?YW9ZcHQ1NHpIMnRBeWQwTENJOWhBNDA3RjUzM1IyNVpVUU9RUSsyb3lnS3hz?=
 =?utf-8?B?SUxVRUxXazM2SGNab1o4N24vaUZBR0tScno3WVF3S0YrOGRoNU5iUktkQ0Rz?=
 =?utf-8?B?ZVZ5Zi9xSnlpb3FSUzhPY1JqY1FmRU5udWVJVnJLTVFEUDZQOU1ZVDNJYllh?=
 =?utf-8?B?ZnRuK2FCaGVlZkt3WGJmcXhDRC9YT1poc1hrd1h5cStUZUpsVytMcHl4M0Y2?=
 =?utf-8?B?TVBZWC9rSElMZlFWZ3JZUzhTRGYyR2VwMnFFYlhwYkdTT2s4YlVUOGdKSnBH?=
 =?utf-8?B?M0k1SUdoQU9BWjgzQ2VydmNDeFR4Z0FkdExGd2xLeW81dUpKSER6c01yb01S?=
 =?utf-8?B?dHpkR3p0SlpRc0tEdEkyV0JBNjBpdE5RVi9WN1d4UVBxN2ZmMEJUdU9MRTBp?=
 =?utf-8?B?QktBVEp5Vi9YT0cyZ1MzU2d5Z0FzVTVlcnlsblNWak1IWDgveDUxYnBMdjY5?=
 =?utf-8?B?THBUNDJ6VmQ1azVhbHFWQ2FHNG9vOUMrZ1RseWxGWk1XQ2szMGZDeTNtT0Nj?=
 =?utf-8?B?SklhdGFsR2xwSnZsTWptVUdTdDY2VG5CcTVkcUwrYkl3VTU1bGtiYjlpVHZS?=
 =?utf-8?B?K2hzR0dIUmpEVFl6UFFQUm1kdVZXOVd5TmNibGVKQk15am5LKzlJVUNlaDhU?=
 =?utf-8?B?Wll0MlVLYlRmbnZqSEFLR2hoalgwRkxLYWFFZEVmY2RESyttdDF5V3c5UUx2?=
 =?utf-8?B?TDdnbHlHRk1aZlNFRkFsU0NxOUJtVUN2cXlBQ2pLL3JHVXF4WEU4U1lRTVRP?=
 =?utf-8?B?aFpta3hGM05JeS9JM0ptYjg3ZUdvSVJSb0NVZnBWdTkyZE9BYThRZHV2cVA5?=
 =?utf-8?B?STJKYXpSVStBQ2J3RFB4WWFVbG1aaGlranUyQ0Q2UVQ4eUNybjEwOW9ibjNt?=
 =?utf-8?B?TnFZS0ZCdml1K2M5clFnZ3hkYjlwYnMvNTRTdWlwSlNQQ3RHVTB0Y1NCNHpv?=
 =?utf-8?B?Z3FtSU42c2NqdTRVK0FtZnVMSjVCME5VQ1Y2UHRHSlRvQzMreE9yMU1Rc0pv?=
 =?utf-8?B?MnBSOWliZ1UwbVBCZFpYMmxBTzJQNzZXbVljSlRBQVJaejJxK3ZrKzlERzRv?=
 =?utf-8?B?S2lsUHQ3dE91ZkFMZ0hjQ3dkb1kwSmpMVDhiTFEvcG9meDBoampQUlFDZkRL?=
 =?utf-8?B?UWZHSXJrbUtqMEZuVzdGcnVxcGQ0TzRjZndkak4xR0dURUVnTkdJcFg5Zkxl?=
 =?utf-8?B?Z3JrQUZwKy9JZlpzTzlwMTJ4Z1VXenB5OURJYWYvTU1taGZvYkJUZUJHblB0?=
 =?utf-8?B?VGF2UFRSdmZLbjhNNk9CcVpLa0w0NWUzRjZEYldZRDRDWnUzODBTRkRDS2VD?=
 =?utf-8?B?c1FkK1hpblM2TU5jSHZyZElkZUxISy9RNXU2c0VacHNLUDhQZUR5Z2hOTUZs?=
 =?utf-8?B?dVpVVE43Q2taNncvWHo0Tlh5RVlOZjJDREhxeFdHWEdnZ05TaUFYZGo0bHMw?=
 =?utf-8?B?aXQzUkdMb2hteklWaVoxeFV6YkNHbk9WL2RNYjZtOUFscEJ3Z0dSeFFHWk5N?=
 =?utf-8?B?WmU4V0xhQkQwQ0NPMGtyWWt4eDdJL0NwTmphenVvVVJDcjFub09TR0ZwTThK?=
 =?utf-8?B?emdpcnYwRFNZbXFmU3greDFkN1lPdlN2UzdEcTlielcxRWZ2Y0VzK0pWK2VY?=
 =?utf-8?Q?fSk8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76835a81-08a6-4d1f-c489-08dcc7c99c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 01:26:30.1407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oUtNMT5qjZZilBbE+D4Vz2l5l5l1mRRhXog2uYOxD082z7+don6GtAshamQ15qEr
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

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KUmV2aWV3ZWQtYnk6ICBZaWZhbiBaaGFuZyA8eWlmYW4xLnpoYW5nQGFtZC5jb20+DQoNCkJl
c3QgUmVnYXJkcywNCllpZmFuDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBD
aHJpc3RpYW4gS8O2bmlnIDxja29lbmlnLmxlaWNodHp1bWVya2VuQGdtYWlsLmNvbT4NClNlbnQ6
IFR1ZXNkYXksIEF1Z3VzdCAyNywgMjAyNCAxMDoxNiBQTQ0KVG86IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnDQpDYzogWmhhbmcsIFlpZmFuIDxZaWZhbjEuWmhhbmdAYW1kLmNvbT4NClN1
YmplY3Q6IFtQQVRDSF0gZHJtL2FtZGdwdTogcmV2ZXJ0ICJ1c2UgQ1BVIGZvciBwYWdlIHRhYmxl
IHVwZGF0ZSBpZiBTRE1BIGlzIHVuYXZhaWxhYmxlIg0KDQpUaGF0IGlzIGNsZWFybHkgbm90IHNv
bWV0aGluZyB3ZSBzaG91bGQgZG8gdXBzdHJlYW0uIFRoZSBTRE1BIGlzIG1hbmRhdG9yeSBmb3Ig
dGhlIGRyaXZlciB0byB3b3JrIGNvcnJlY3RseS4NCg0KV2UgY291bGQgZG8gdGhpcyBmb3IgZW11
bGF0aW9uIGFuZCBicmluZ3VwLCBidXQgaW4gdGhvc2UgY2FzZXMgdGhlIGVuZ2luZWVyIHNob3Vs
ZCBwcm9iYWJseSBlbmFibGVkIENQVSBiYXNlZCB1cGRhdGVzIG1hbnVhbGx5Lg0KDQpUaGlzIHJl
dmVydHMgY29tbWl0IDIzMzM1Zjk1NzdlMGI1MDljMjBhZDhkNjVkOWZkZWRkMTQ1NDViNTUuDQoN
ClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNv
bT4NCi0tLQ0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgNiAtLS0t
LS0NCiAxIGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvYW1kZ3B1X3ZtLmMNCmluZGV4IDM0NjRhN2E4ODBmMC4uZjBjY2M1NjBmZDVjIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMNCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jDQpAQCAtMjM5Miw3ICsyMzkyLDYg
QEAgdm9pZCBhbWRncHVfdm1fc2V0X3Rhc2tfaW5mbyhzdHJ1Y3QgYW1kZ3B1X3ZtICp2bSkgIGlu
dCBhbWRncHVfdm1faW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdw
dV92bSAqdm0sDQogICAgICAgICAgICAgICAgICAgaW50MzJfdCB4Y3BfaWQpDQogew0KLSAgICAg
ICBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrICppcF9ibG9jazsNCiAgICAgICAgc3RydWN0IGFtZGdw
dV9ibyAqcm9vdF9ibzsNCiAgICAgICAgc3RydWN0IGFtZGdwdV9ib192bSAqcm9vdDsNCiAgICAg
ICAgaW50IHIsIGk7DQpAQCAtMjQyMiwxMSArMjQyMSw2IEBAIGludCBhbWRncHVfdm1faW5pdChz
dHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwgc3RydWN0IGFtZGdwdV92bSAqdm0sDQogICAgICAg
IHZtLT51c2VfY3B1X2Zvcl91cGRhdGUgPSAhIShhZGV2LT52bV9tYW5hZ2VyLnZtX3VwZGF0ZV9t
b2RlICYNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFNREdQVV9WTV9VU0Vf
Q1BVX0ZPUl9HRlgpOw0KDQotICAgICAgIC8qIHVzZSBDUFUgZm9yIHBhZ2UgdGFibGUgdXBkYXRl
IGlmIFNETUEgaXMgdW5hdmFpbGFibGUgKi8NCi0gICAgICAgaXBfYmxvY2sgPSBhbWRncHVfZGV2
aWNlX2lwX2dldF9pcF9ibG9jayhhZGV2LCBBTURfSVBfQkxPQ0tfVFlQRV9TRE1BKTsNCi0gICAg
ICAgaWYgKCFpcF9ibG9jayB8fCBpcF9ibG9jay0+c3RhdHVzLnZhbGlkID09IGZhbHNlKQ0KLSAg
ICAgICAgICAgICAgIHZtLT51c2VfY3B1X2Zvcl91cGRhdGUgPSB0cnVlOw0KLQ0KICAgICAgICBE
Uk1fREVCVUdfRFJJVkVSKCJWTSB1cGRhdGUgbW9kZSBpcyAlc1xuIiwNCiAgICAgICAgICAgICAg
ICAgICAgICAgICB2bS0+dXNlX2NwdV9mb3JfdXBkYXRlID8gIkNQVSIgOiAiU0RNQSIpOw0KICAg
ICAgICBXQVJOX09OQ0UoKHZtLT51c2VfY3B1X2Zvcl91cGRhdGUgJiYNCi0tDQoyLjM0LjENCg0K

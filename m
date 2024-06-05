Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56E4C27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 18:22:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E4610E314;
	Wed,  5 Jun 2024 18:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="02lw8+o4";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20AE110E314
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 18:22:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Riwj6m7WQLY05T4om8K1vR3lwNPvfav/f+7Fyu6iWo7WCCV/BkFuADaFaLsWM8A67/hkQTTao+Lvg1/2koVodYV+3k1/F/Xygg/pVo+g4wz/tma+cSQhUIlnpRd/NExBoMbJYJ+taGRizdnN8aY4joesE/UnMBA7ROC5nUiQBHxZtdXkYIMBfgnwiORN51WYCynFMZ17J1Tg3IPodPdHDbbNSmP4AXbFIVFkfJau/PRbo0KssMFHgdJWI4wKygRfWjMnkmITFFTzhI85fSe9NOIJSRUo2XoQWfT/LYUq3UDu2LMzwlbeLW298c0dAdiXxlQsfWZ/gMB6XTS4pkyETA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sPFqpPR37uvA/eAnp1NnhoZWcPetofbatykczYs8r8=;
 b=S3bbyILhNObPO9mqcWvWqEWmSfY1ti+W6U580ZdKQolPyk3TGFFy26KFB/ixyo2BL4gVZfZMKU1iG6CDd0R4Bj7BQm8RrialaF/zI2xcx4DqzQTEIFSLkGLC0Z1ZEsvk3l7oztWFcVJdlPIEzV8d1vguS1Ova/QxXhvOU6tTPU+OeUYKcFwHZgcqBugA+ygOTv1b+7vg1svNHd1RxOC1LbJGn6u3RYTa/+HW5MrvH/Zy8RkCblfCWQJo60WXX7PvK0ZI5y/ryIYL/yKMDAuqfJkhRemlD34+1wIqsCXfp8xwHmLGsBkop7TE/gpSgaC0HTXh74QUXNFzN2P/Wxxh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sPFqpPR37uvA/eAnp1NnhoZWcPetofbatykczYs8r8=;
 b=02lw8+o4IEPHBGSYkwavJxrFAaivE/QsI8IhvbW/kEdhvU3uY4WZq/I+UxDfVpbGvyYB0LaypqotKyYvS/TobqTvHpEH2vliBxfewVSAuqKTPmBbM9f3ZoXiKRpownYVBGSWbicYWC19BnC4TtJMb/mTF7GL2nKIMsVs4xj7Fjo=
Received: from CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Wed, 5 Jun
 2024 18:22:26 +0000
Received: from CY8PR12MB7415.namprd12.prod.outlook.com
 ([fe80::3f74:9380:7a3a:6929]) by CY8PR12MB7415.namprd12.prod.outlook.com
 ([fe80::3f74:9380:7a3a:6929%3]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 18:22:25 +0000
From: "Zhang, George" <George.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: RE: [PATCH V2 2/2] drm/amd/display/dcn401: use pre-allocated temp
 structure for bounding box
Thread-Topic: [PATCH V2 2/2] drm/amd/display/dcn401: use pre-allocated temp
 structure for bounding box
Thread-Index: AQHatr14BNLaG3egDkSEjoRCS4gKkLG5fO2g
Date: Wed, 5 Jun 2024 18:22:25 +0000
Message-ID: <CY8PR12MB7415BB4C4E7D22892122052294F92@CY8PR12MB7415.namprd12.prod.outlook.com>
References: <20240604202606.697979-1-alexander.deucher@amd.com>
 <20240604202606.697979-2-alexander.deucher@amd.com>
In-Reply-To: <20240604202606.697979-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c4c21175-74a6-4265-8295-1769f6934d18;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-05T18:21:37Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7415:EE_|PH8PR12MB6892:EE_
x-ms-office365-filtering-correlation-id: 810af593-8cad-4c49-8314-08dc858c737a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?+JXzvyY9hyGPyJ59Rkg7qJGV/T6XTLGhTsLvAHT1SmxgVWvHokKJZNj/otFk?=
 =?us-ascii?Q?nu/JRzbV3LFZhqq2uqKd1bwWHWrKPRpj6/1ueOFBpLjJKG9xC9P5VN3n+6e9?=
 =?us-ascii?Q?APQFIiJQu5plGC0n8TkJ1QN5220viSmEVhOctSyn0Npa1PSIZ4Qlr2xHyw29?=
 =?us-ascii?Q?6LX9WiAXqykBFWezWbIlPBgpL5c0oDnMSjizV13VzsXphCK7N2ZqkBR94enj?=
 =?us-ascii?Q?Yp8zkCHDKeuyR4BZy1s9T+yNysTn0sODtoFkDY6fhvOMIoUd/diLhUqgZ0sO?=
 =?us-ascii?Q?bs81uHN17E9a5PdCbxhG5uphA+pA0fs+Zsuy/83ZX2rpambwTjycrOviNQaA?=
 =?us-ascii?Q?zaID3Fkai/9ESUoNJmpnIZRZ5CtC5P+mR4ZMp1eLUol9Hv8t5TGw8GeBl62L?=
 =?us-ascii?Q?yp5DIbNH6bctxA05e9N7/iG80qHN3um/CFbREQhmTqleJiggsMV43lZR3S0z?=
 =?us-ascii?Q?kvT9hWAbAuGjwU7HGyUhZ9Lr46iiwWrWoO94al1HJPoq3R01gwo8yELSSs9U?=
 =?us-ascii?Q?CqIZVURfk74obmx1c/pNtZkrkMXhQfcenh2dm4Jo63FhzvlPVc86ngmBbUu5?=
 =?us-ascii?Q?fddaREs2R9FsyrKmbmzUISDD9KtHX5cYDeHLSCoMiTW/BRKlxEtZWMvAbgks?=
 =?us-ascii?Q?APg0ONQ0bP12V9/krLiGWuIke29wRNryHn0zS+iuVUlrXXOi6N17ruYil/fQ?=
 =?us-ascii?Q?WB7ExOK7/qJi1M3K+toMl8rR4QGNUTV/AIAZez9GpfTQJ/uM7ay6AtCfIXIw?=
 =?us-ascii?Q?c5l9kcpgOAL+R2uSPbPaAHWdIUfqkY/pDPGYOmrzEyuN13/t5eb+jPhwmk0f?=
 =?us-ascii?Q?MIGldLpF+x18ee29AcHWWEs+Pdpk4A62hVcqwz9X5CbFMPMBrep4M6FzJ8JE?=
 =?us-ascii?Q?SqDHikeFHEfJD+y2xrg+CvwgNhNqP4VSKQ1UdXHwDOn6OiqQ4Lf0vG1HSh8/?=
 =?us-ascii?Q?n7zBavqgx89awqbJb/lLceYDtgoKywRwl9caHMujKFVOVMG98REZ37AcVHxd?=
 =?us-ascii?Q?DKv11ktFDvRGJNHqY4Gi0CNqm/O1HHjN4MmAb7Fr/7B8sU/Q5kkvz5zaND/u?=
 =?us-ascii?Q?dWjRpeAtS/jCI7SFv9zobgvRoJxdOjA4sRSoR8IhBO0/m62KU+lvO9CI0Hgo?=
 =?us-ascii?Q?yAuJV/M//nD/xX3qky9l5wH0DVdnx4l1xMEKh3oNTzaGCjRW+ZCWaMpn00ty?=
 =?us-ascii?Q?JWLIa7nki4W9RkhmiBXmZlV0LLxnw2doTjAJcaxgmY9ZHOwHvlMdPqjr/ou+?=
 =?us-ascii?Q?hdqD3VP66AWo5wLKEgLiR2nq/Zh0Rd4zyUaqvrfN1M8vnH1Y5Z1dq4XkUdMW?=
 =?us-ascii?Q?7IFUQYtMd/wSlbiEjjUYtlWbTKUG9IQ3c4VjB+xDmd9vQw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7415.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tavTp1mAj7RIqPRcWu7CKuO+jisJErEHBkQROKQM2kjR6L0tN/BlmgdHP+N4?=
 =?us-ascii?Q?fA578VYvO5n5zeX3n3PE5YLcTSDtqP9vuXzT/ACV4n/gaJkM6p+vrGap+Aiv?=
 =?us-ascii?Q?HB2MCNGTRdO+OwymEitRevqJjM/iq9uQomb6Oo6dw9AVtSFAUhNpcMzTa5rK?=
 =?us-ascii?Q?d4rf9JjhmmGj8ueqz2u0VVip1qrzrJQnqabej8G3CSCGY+1mwtmW35FAakgD?=
 =?us-ascii?Q?Vji8Ihcy32nppKU3xHWuXycdH17wi063WBCvnH1+yojqqQNZfeflP/CPpkuc?=
 =?us-ascii?Q?1ly3eKfOHL4dC+0j/WMGNsEfwEvJaT+HkCqShHQIONtQxGsxwPAykjbdEkBb?=
 =?us-ascii?Q?Ien/rPAPWJ/XfbHgBIOmlHWNNoJKc2jGT0d+smh4gSE5p2nunrAKiTZp6MWX?=
 =?us-ascii?Q?ay8O2jer+e6u2zye2UMNQDeMuB1K/H2PtLA7B7E7O0cMPH4Ol1yl41x9t3Nh?=
 =?us-ascii?Q?ESKdLokWq1k8KD+IW2Dj6AK7V5vkPdA1L+V8rRfbQPRdF2AfIn2LgH4qPZuZ?=
 =?us-ascii?Q?8eUKTx9n9wZkReiZrXP5pvFF3mUttKbXScfk1M+CpkCcxfrW1GiPbaSdNeRE?=
 =?us-ascii?Q?ZCJy3AupJtR320a+voHdWewXMepUFkOP2+q4/NNwp0LLk49RTG5NnUdaiyeD?=
 =?us-ascii?Q?wEpYfqnOf7ib2MbSOdNqYEscWT9UFJfl7Ty/duyqOU0FIYJNH+2GQ6cFYuV2?=
 =?us-ascii?Q?+BIXR+dzdLZmncIoJgR48rFOiNL+t17Cdhu6twdn1j69sFhoaaZ8X3EeTgZr?=
 =?us-ascii?Q?Aqzmg1toa+MdfK2jLL1OhDkH20DQUjr0R49hCaZ3JsFLbS4ayaLpGyTdigK3?=
 =?us-ascii?Q?O3eUNDtSTQDqzGg1Kk4wSsDGCw1BgqSef71tGhjZ+lxp8WMJ9N14R+PN/HPB?=
 =?us-ascii?Q?/9rIw4s5KwTtfCgjWhAF83Vfl1V50XDcl9Xz/a0bHnYLfwDhNpC7fBBLUSSv?=
 =?us-ascii?Q?VSzNPHJK6W5QOkL6bH8IoM7Ill25p0SV3qn0o4iGjW2OB6kWXV1Gq8mpVINQ?=
 =?us-ascii?Q?gQWSn0aO7kCRcJ+HJp+hnB9+8aBPgRd+j9mDqWUXYKwJP+byuS3+HI6Ps2QS?=
 =?us-ascii?Q?lJiyQRSNLsS6rSgYGSE2YJwI31DE4mqHb1RT4IKWD1sogBUBKnzH8KILAL7q?=
 =?us-ascii?Q?2xzANAQqWF4Nd54Zd22TUYZibLisdMThdXUhOX1z1yYSxyeM59Iyy+Oev71h?=
 =?us-ascii?Q?PzbpoExLK8D2hlrKoWmTc7xHxMX/1LP9ukvCAIsEpeARDq9iiFCBoYE9yrCP?=
 =?us-ascii?Q?lFd2OM9nICQK4LBkFUTk0rcD2UoD2qJfmAMHCuaC3fcdutNHAqYlKGS255wh?=
 =?us-ascii?Q?Q4y4XyBqqWBJN+LjL7MtmWF5KKTQIuH02E12RPD/hZlL0lmhGW6sGhMDj/Ds?=
 =?us-ascii?Q?HV9pUT9UW3Dfd2VqrOuERqdSGCKGaQKGfQQa/yhGmnCcLG8nQyE+YWL6LTCS?=
 =?us-ascii?Q?nyO8BnUJ+onSZJOI7bnhn6vaOPb0yJFZl3g8xTYQHa3civMspUbVTZzTVMfZ?=
 =?us-ascii?Q?D0oUynO+t0TH3uQsh7iO2Or5xf/J3HpfCYQGTmcD/CSXGJNX9VOgekZsm6p6?=
 =?us-ascii?Q?WaJyx0jS1lvsvnX2/I8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7415.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810af593-8cad-4c49-8314-08dc858c737a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 18:22:25.8833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07RY4no8q5UrhDMe5ruP0oEmmy0Cx1GwOz7Ap5dcWK5bGGE+IHXsrl0beUqXpEhuzlykbwA0UWZfmg/61dBQrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892
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

[AMD Official Use Only - AMD Internal Distribution Only]

Tested-by: George Zhang <George.zhang@amd.com>

Thanks,
George

-----Original Message-----
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, June 4, 2024 4:26 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Mahfooz, Hamza <Hamza.M=
ahfooz@amd.com>; Zhang, George <George.Zhang@amd.com>; Arnd Bergmann <arnd@=
arndb.de>; Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Su=
npeng.Li@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Subject: [PATCH V2 2/2] drm/amd/display/dcn401: use pre-allocated temp stru=
cture for bounding box

This mirrors what the driver does for older DCN generations.

Should fix:
[   26.924055] BUG: sleeping function called from invalid context at includ=
e/linux/sched/mm.h:306
[   26.924060] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1022,=
 name: modprobe
[   26.924063] preempt_count: 2, expected: 0
[   26.924064] RCU nest depth: 0, expected: 0
[   26.924066] Preemption disabled at:
[   26.924067] [<ffffffffc089e5e0>] dc_fpu_begin+0x30/0xd0 [amdgpu]
[   26.924322] CPU: 9 PID: 1022 Comm: modprobe Not tainted 6.8.0+ #20
[   26.924325] Hardware name: System manufacturer System Product Name/CROSS=
HAIR VI HERO, BIOS 6302 10/23/2018
[   26.924326] Call Trace:
[   26.924327]  <TASK>
[   26.924329]  dump_stack_lvl+0x37/0x50
[   26.924333]  ? dc_fpu_begin+0x30/0xd0 [amdgpu]
[   26.924589]  dump_stack+0x10/0x20
[   26.924592]  __might_resched+0x16a/0x1c0
[   26.924596]  __might_sleep+0x42/0x70
[   26.924598]  __kmalloc_node_track_caller+0x2ad/0x4b0
[   26.924601]  ? dm_helpers_allocate_gpu_mem+0x12/0x20 [amdgpu]
[   26.924855]  ? dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
[   26.925122]  kmemdup+0x20/0x50
[   26.925124]  ? kernel_fpu_begin_mask+0x6b/0xe0
[   26.925127]  ? kmemdup+0x20/0x50
[   26.925129]  dcn401_update_bw_bounding_box+0x2a/0xf0 [amdgpu]
[   26.925393]  dc_create+0x311/0x670 [amdgpu]
[   26.925649]  amdgpu_dm_init+0x2aa/0x1fa0 [amdgpu]
[   26.925903]  ? irq_work_queue+0x38/0x50
[   26.925907]  ? vprintk_emit+0x1e7/0x270
[   26.925910]  ? dev_printk_emit+0x83/0xb0
[   26.925914]  ? amdgpu_device_rreg+0x17/0x20 [amdgpu]
[   26.926133]  dm_hw_init+0x14/0x30 [amdgpu]

v2: drop extra memcpy

Fixes: 669d6b078ed8 ("drm/amd/display: avoid large on-stack structures")
Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: George Zhang <george.zhang@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: harry.wentland@amd.com
Cc: sunpeng.li@amd.com
Cc: Rodrigo.Siqueira@amd.com
---
 drivers/gpu/drm/amd/display/dc/core/dc_state.c      | 13 +++++--------
 .../display/dc/resource/dcn401/dcn401_resource.c    |  8 ++------
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/d=
rm/amd/display/dc/core/dc_state.c
index 8ea9391c60b7..06b22897137e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -192,15 +192,14 @@ static void init_state(struct dc *dc, struct dc_state=
 *state)
 /* Public dc_state functions */
 struct dc_state *dc_state_create(struct dc *dc, struct dc_state_create_par=
ams *params)  {
+       struct dc_state *state;
 #ifdef CONFIG_DRM_AMD_DC_FP
-       struct dml2_configuration_options *dml2_opt;
+       struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;

-       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERN=
EL);
-       if (!dml2_opt)
-               return NULL;
+       memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
 #endif
-       struct dc_state *state =3D kvzalloc(sizeof(struct dc_state),
-                       GFP_KERNEL);
+
+       state =3D kvzalloc(sizeof(struct dc_state), GFP_KERNEL);

        if (!state)
                return NULL;
@@ -217,8 +216,6 @@ struct dc_state *dc_state_create(struct dc *dc, struct =
dc_state_create_params *p
                dml2_opt->use_clock_dc_limits =3D true;
                dml2_create(dc, dml2_opt, &state->bw_ctx.dml2_dc_power_sour=
ce);
        }
-
-       kfree(dml2_opt);
 #endif

        kref_init(&state->refcount);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource=
.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 8dfb0a3d21cb..029ad7bd7b5b 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs =3D {

 static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_par=
ams *bw_params)  {
-       struct dml2_configuration_options *dml2_opt;
+       struct dml2_configuration_options *dml2_opt =3D &dc->dml2_tmp;

-       dml2_opt =3D kmemdup(&dc->dml2_options, sizeof(*dml2_opt), GFP_KERN=
EL);
-       if (!dml2_opt)
-               return;
+       memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));

        DC_FP_START();

@@ -1600,8 +1598,6 @@ static void dcn401_update_bw_bounding_box(struct dc *=
dc, struct clk_bw_params *b
                dml2_reinit(dc, dml2_opt, &dc->current_state->bw_ctx.dml2_d=
c_power_source);

        DC_FP_END();
-
-       kfree(dml2_opt);
 }

 enum dc_status dcn401_patch_unknown_plane_state(struct dc_plane_state *pla=
ne_state)
--
2.45.1


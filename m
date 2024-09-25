Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EED2CF9C6C
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 05:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63E210E78B;
	Wed, 25 Sep 2024 05:52:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nSsGYZYD";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2049.outbound.protection.outlook.com [40.107.100.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23C2010E78B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 05:52:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dey3Bk5L3sbqYULZI1KJTkbirwJekbFeLuay7r5qMZKl3TrzgDqw1Qy153RIXgjJi7ZOvrhgWDnZaoZMNo1to7bU8CRSJY6dTGOdsWNo1/VTZdZ4Pa0QgJXFnIFwG3lLbR8EURsna22sx2cMJKvtRPUBv53s0Qd7nA3oJti36KttTOxmL0rIPUF0iye0tQrF+tQ6/xrCfmYLDcthNFxcfFjra6pFdEpwAVudRekDepff1/UwBfLp9V82MYewIFeTwmpgJMuFOe8akaQZa+sLMNSoo6TAOqUAdwenlORu9De9TFGt7YyOynV9m9gJcMWRMP8uykc2ldTenXuN3Bk4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PAwe8bCqPEDE7dtZ1egrCxk1dKGCBSSwe/3+Uj1+Tc=;
 b=Z3XFDEHPI77vPBd1fzJ1gnfO7amwsbBeiXloEfNsYWA7KKB9yzpX4XU0mO4MGvwTDeun39Jgm+VT91GC2NcfwFEpDUpF/RRtEvPzkKo8EOzNEHdDixRpRTp5Ed8vBXksC/aqoymwDyHrVpUr0MEbEg9aQVNSAzrHeFXqIt5EmlKWSObO0IlpsuAKY+B2FHipIuYXm9+EbQlPSnvr9IgXplya7ELHdNyRizUYA0avQOGMoZ80rExXzrDx4KRy3iyHjHYZPykU8+PkxKP7J9HYC7o6fw+zKG6R/1lJ4JvgyuADgIFhhg1UvUm2iV49iTReuJgiXFamnXs+lT4KfD9n0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PAwe8bCqPEDE7dtZ1egrCxk1dKGCBSSwe/3+Uj1+Tc=;
 b=nSsGYZYDHyTxn7HQbBJ8z/04YM24R+D0rnTLWv+JA86m3pwmu8W/LeFO0YSASYgGqlkG9sVL6PHa5qj6C50cgGg+tr0d9PYOvZtOAAHPR+Bj4ImRvlQeVg11VWgzED2przduUZQLpHDviw2i48Lt2fSwfPfuTTvx1F6jrcoDt4E=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 05:52:03 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::6015:2417:2e27:dd79]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::6015:2417:2e27:dd79%4]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 05:52:03 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "YuanShang Mao (River)" <YuanShang.Mao@amd.com>, "YuanShang Mao (River)"
 <YuanShang.Mao@amd.com>
Subject: RE: [PATCH v2] drm/amdgpu: Flush tlb by VM_INVALIDATION packet in
 sdma_v5_2
Thread-Topic: [PATCH v2] drm/amdgpu: Flush tlb by VM_INVALIDATION packet in
 sdma_v5_2
Thread-Index: AQHbApxI7WbUrdUnOUOaLlnKXb1lxLJoF6ig
Date: Wed, 25 Sep 2024 05:52:02 +0000
Message-ID: <DM4PR12MB5072F175E7E649CA11150157E1692@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20240909093955.16747-1-YuanShang.Mao@amd.com>
In-Reply-To: <20240909093955.16747-1-YuanShang.Mao@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4c4f4916-fc14-4709-8eea-0bd259c00e1d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-25T05:47:42Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|DS0PR12MB8504:EE_
x-ms-office365-filtering-correlation-id: 4e828548-e2ad-4a5c-d2ef-08dcdd262dfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xT9so5GgBkmkyU2QOkiBvDmjB7VG/QKOHWnFiPXTx2mUUxLek00FLNTs/qjg?=
 =?us-ascii?Q?JHAroGXkRgsV/rpA+21y+QmFj/9X+3Hk7WMztTcmHloL0RuVxhQuah5Pxigl?=
 =?us-ascii?Q?boNcqp7dMOK1OcySFw9AohcEHMMhe+/FaIlt+SepqHoIDvf5kICuyVB8StLo?=
 =?us-ascii?Q?KmIdnPt1knCU35uDSk+ROsnRuThZfzntRWFNg5g2XQfJsNMYUVECKc9PkP+f?=
 =?us-ascii?Q?IthyXpYQIiDHa8samd6PncmIuKKkWzAdK09GzOCVXOuSjyvEg3IQMStCpoFn?=
 =?us-ascii?Q?lIP1WLOOv7DYdrXfSpupbGjO3CQu0kX/MSk7BCqyPp2F/WBkjKrz82CodEld?=
 =?us-ascii?Q?PkQjY0JRNRTNM+KILEXKPR4IwMzamdAD7WNpxZZKUmnqcGeqmamasjVIN2Xd?=
 =?us-ascii?Q?OJ1y6uHJzfbd317eiYCxb8vwnJ50pvLPEZmzpxMIEz/dSWYnXPeIu0aOqQqM?=
 =?us-ascii?Q?Ahm3RmRilzEUtIDHr7WGcK7Thmk3TqVAOD3uOnvroSXIXIeeTY5r9xc7qE60?=
 =?us-ascii?Q?s3l8Po1H7l3IDnajrjesnZ4pv2NNvAkpT5H7ZnAwVJq4hH27XnOmek2zaHtX?=
 =?us-ascii?Q?6n7CoY0kVJADOZup0aGn7zZYYZ9Z2Iv2qGbSmw0tScEwDtBNq2nVe9MYN1Us?=
 =?us-ascii?Q?IcgCYOOHSFfyOItYTPPfgBlEepkhVj9QCIfFGnyTXjGCyJ5q9U79Koa1y95Y?=
 =?us-ascii?Q?XAAkiYMO+zVyNGVGgsi3Fp7xKZ+l3E89aJEnWtXSACwiPdq9qeboSqtm0kz8?=
 =?us-ascii?Q?0p/M8H4bLyzj9fJmbZ0Q1McD+c+Ozd9xbEAwE3NEjCJRKPcs40YJmmairIC8?=
 =?us-ascii?Q?k8awqyr6KssbbHKvuGFAPwVsR0FdNG/8utEwhwgIzY/+whqFU5K1JhZ47khh?=
 =?us-ascii?Q?pR7UOYuFAKmQO+YDqyx3fwqRxBgTQz6T9x23wB49aPC57KsZYxytYYiHzAKO?=
 =?us-ascii?Q?89vpclNh3rD3kWBjLvOtOjD1bbVCDlNzTGkOiEEwfJQJRtTexinnFVtbXGbI?=
 =?us-ascii?Q?UQZOFMGX+e4qG4gSoE4VoNjsIANvjgeyEBCgGn7qldMYckQdncB7FdLnGWin?=
 =?us-ascii?Q?tdhCfnOU8oK0vO3D7cJ0KYDzeALMGEFLpCMupkH7VUAwvqmGaOjrLzLO50jB?=
 =?us-ascii?Q?Qeuwl6PxvEZrfnajZqxKecIHEN18Kt7dyB1pWA0JPYNn9GTgHirGwRSP0Dx+?=
 =?us-ascii?Q?3lg+zNU6Sz69yGZ9m97yF6ouNap4hR4BfR/XnltPPcCyK061bgoW6cCoMPnW?=
 =?us-ascii?Q?xVNBbDVQ+R9qt04WwcMRf9NYW6UacZ7eTsFbvy63knYM71iXlcikiyB1vJgZ?=
 =?us-ascii?Q?ivY004LFUCN1NUbH7+A5XBuLuPnmVeil6vQ+d4PXmqrobw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1gxBGraYXLb9qw8qneIcq7qg/oHn9evcT2jLBuPvIisLFnsbeo/y0aNdTfPb?=
 =?us-ascii?Q?Ky1LN3RaQCRDLodkbnN8mzjiPlKtbkQI17xwRVaAlbgVbwz01OUWzcJV+ubu?=
 =?us-ascii?Q?xak/+yhzVZ7MbGL+H4+fDCqqnDIWMTbSdAQAPjxfKTogY/g+xbCBJziJpnC4?=
 =?us-ascii?Q?8gk8KR1nH6+6CdGprEp6eBXwHDTc3kywiDuTdwD4JjdEPI5xNGMhxS1RDPdO?=
 =?us-ascii?Q?iByKIqtfi6A8DnflWNxVvAPWBWImlPDMDr4dTa470Axp/g7IXi85u2bK0Ug1?=
 =?us-ascii?Q?srNms3BVe5rPp13lAydkm2/G+igpDWRtyIrFnP6Qy9udT6uaFY/L0hbyuG6/?=
 =?us-ascii?Q?4l3m8Srukhb+FFfjmsgrJcZigKQoZPK8yFB9lK3yJGU/pBL8YSW5LpLhWHsf?=
 =?us-ascii?Q?74b6VABkgH4XcBPAYQCzI1R/jSIUjkV0WfZaozeExTBGV4jF2nBsiNmkSV5V?=
 =?us-ascii?Q?IQH6ZkLz9ew57RMJH1anUYz4y5KhOIWBXBlqA9OOl3NIM4M+vnsqrJwCSNyQ?=
 =?us-ascii?Q?6QSxdQhuSIHMBHwGSAZmTzcBEnvDaUVfEdDd9IWLmVZuKIE58bWy9/L3CI6y?=
 =?us-ascii?Q?k7cv8q9FipXXyhszKTJkZlfQbVjOgMrOI/+SkVR6BZ95NACLRrEc/HD1SAI6?=
 =?us-ascii?Q?ASh+Y6BTIK+3zFPYg26M+sDWVkadgSkP/rIgxiyMSEGIvDWWwMui+rGAopdX?=
 =?us-ascii?Q?yVrRoscI3cabOw/Hppnq30P+qDXX6R4o+wg/zhNz679K1aUOn1YuofQ9TRpC?=
 =?us-ascii?Q?XlIlYRWC5YRD5PGMnqk8zNtyrXVGv3fGM2PC8EA/hpDvZ400PE8p1DwDDG6B?=
 =?us-ascii?Q?cgr8koRAO1KB0iHe48KaBjrQQyvalNpstOmDkUF8ftkGfdT8PEhSxlCs+7yw?=
 =?us-ascii?Q?5bXd91hjgsICTd9de+99ytZLmztw0R6en/IMT1ghLVUseH9AAwFyZeBFN0fs?=
 =?us-ascii?Q?3QV9wkkswXIJbi0UyybM3IsFzL9tNGU14nmjZ3I1u4taNaEf+g4bkJ0aKnPk?=
 =?us-ascii?Q?2Uc3rFGGDmRLwUfUW79gxGZBD3oWLLYErl81OY1ihSj4dT5rn6esf8stSatO?=
 =?us-ascii?Q?ezc5teEVY0x4CUYQ9VBzg4oozbVv14iF2BBqZ/o0lhkU1AT6zcXIhwZBCxuS?=
 =?us-ascii?Q?9ktU4wRzgqmouRXBbMGqsz8eeoJ+09AZxHPYv906L3IzED7JGP4RLdjU/L9A?=
 =?us-ascii?Q?yp1DpsMqNlyuNd6my288XtiW6HPD5p8vlLDxBwVnaAYL5WBKo7F0mbcYjnS7?=
 =?us-ascii?Q?pq/kH65Wpf7NNV9ZFiRb3W589tQFImuuS1+axWwV0Z0TafAF5gl1pb3jIybY?=
 =?us-ascii?Q?q8czipycD9pYifmmkR892QUquUwv0XxSeEiMRZWlZk1riFiDs51npd/HrFDV?=
 =?us-ascii?Q?cvF5R8sWw8pMMR52q/cEv1VED5m2bL9lDVjJ+09DSPCSnkL6UrQfCFXfB3fO?=
 =?us-ascii?Q?Q8q6RdPm1LeF669T7NjPni2adyQnCFXMbsVgW304smVBK9vGFl03WtryKmw2?=
 =?us-ascii?Q?Fh/q+iAOZetqieme+SvNeZ5fEx9IK5qdnNhOEGjiW3oUb6d4oXFdrHHSaEKt?=
 =?us-ascii?Q?OTRDNOS24DSfVEzYfIA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e828548-e2ad-4a5c-d2ef-08dcdd262dfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 05:52:02.9773 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q/8C/PHsKRCVXViU8ai6v3fu92BYC2QS9bqTXqjPnx5rMe+4e2ZVD5WuTUYj1BrE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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

Reviewed-By: Horace Chen <horace.chen@amd.com>

Thanks & Regards,
Horace.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YuanShan=
g
Sent: Monday, September 9, 2024 5:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: YuanShang Mao (River) <YuanShang.Mao@amd.com>; YuanShang Mao (River) <Y=
uanShang.Mao@amd.com>
Subject: [PATCH v2] drm/amdgpu: Flush tlb by VM_INVALIDATION packet in sdma=
_v5_2

In order for SDMA not to be switched between VM_INVALIDATION request and ac=
k, use an single VM_INVALIDATION packet in function sdma_v5_2_ring_emit_vm_=
flush.

Signed-off-by: YuanShang <YuanShang.Mao@amd.com>
---
 .../gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h | 64 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        | 23 ++++++-
 2 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h b/drivers/gp=
u/drm/amd/amdgpu/navi10_sdma_pkt_open.h
index a5b60c9a2418..c88284ff92d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_sdma_pkt_open.h
@@ -68,6 +68,7 @@
 #define SDMA_SUBOP_POLL_REG_WRITE_MEM  1  #define SDMA_SUBOP_POLL_DBIT_WRI=
TE_MEM  2  #define SDMA_SUBOP_POLL_MEM_VERIFY  3
+#define SDMA_SUBOP_VM_INVALIDATION  4
 #define HEADER_AGENT_DISPATCH  4
 #define HEADER_BARRIER  5
 #define SDMA_OP_AQL_COPY  0
@@ -4040,6 +4041,69 @@
 #define SDMA_PKT_POLL_MEM_VERIFY_RESERVED_RESERVED(x) (((x) & SDMA_PKT_POL=
L_MEM_VERIFY_RESERVED_reserved_mask) << SDMA_PKT_POLL_MEM_VERIFY_RESERVED_r=
eserved_shift)


+/*
+** Definitions for SDMA_PKT_VM_INVALIDATION packet */
+
+/*define for HEADER word*/
+/*define for op field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_mask   0x000000FF
+#define SDMA_PKT_VM_INVALIDATION_HEADER_op_shift  0 #define
+SDMA_PKT_VM_INVALIDATION_HEADER_OP(x) (((x) &
+SDMA_PKT_VM_INVALIDATION_HEADER_op_mask) <<
+SDMA_PKT_VM_INVALIDATION_HEADER_op_shift)
+
+/*define for sub_op field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask   0x000000FF
+#define SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift  8 #define
+SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(x) (((x) &
+SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_mask) <<
+SDMA_PKT_VM_INVALIDATION_HEADER_sub_op_shift)
+
+/*define for gfx_eng_id field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_shift  16 #define
+SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(x) (((x) &
+SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_mask) <<
+SDMA_PKT_VM_INVALIDATION_HEADER_gfx_eng_id_shift)
+
+/*define for mm_eng_id field*/
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_offset 0
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_mask   0x0000001F
+#define SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_shift  24 #define
+SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(x) (((x) &
+SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_mask) <<
+SDMA_PKT_VM_INVALIDATION_HEADER_mm_eng_id_shift)
+
+/*define for INVALIDATEREQ word*/
+/*define for invalidatereq field*/
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_offset 1
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask   0xFFFF=
FFFF
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift  0
+#define SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_INVALIDATEREQ(x) (((x) &
+SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_mask) <<
+SDMA_PKT_VM_INVALIDATION_INVALIDATEREQ_invalidatereq_shift)
+
+/*define for ADDRESSRANGELO word*/
+/*define for addressrangelo field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_offset 2
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask   0xFF=
FFFFFF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift  0
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_ADDRESSRANGELO(x) (((x)
+& SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_mask) <<
+SDMA_PKT_VM_INVALIDATION_ADDRESSRANGELO_addressrangelo_shift)
+
+/*define for ADDRESSRANGEHI word*/
+/*define for invalidateack field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask   0x000=
0FFFF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift  0
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(x) (((x)
+& SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_mask) <<
+SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_invalidateack_shift)
+
+/*define for addressrangehi field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask   0x00=
00001F
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift
+16 #define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(x)
+(((x) & SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_mask) <<
+SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_addressrangehi_shift)
+
+/*define for reserved field*/
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_offset 3
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask   0x000001FF
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift  23
+#define SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_RESERVED(x) (((x) &
+SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_mask) <<
+SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_reserved_shift)
+
+
 /*
 ** Definitions for SDMA_PKT_ATOMIC packet  */ diff --git a/drivers/gpu/drm=
/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index bc9b240a3488..46b86bb5cd2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1180,7 +1180,28 @@ static void sdma_v5_2_ring_emit_pipeline_sync(struct=
 amdgpu_ring *ring)  static void sdma_v5_2_ring_emit_vm_flush(struct amdgpu=
_ring *ring,
                                         unsigned vmid, uint64_t pd_addr)
 {
-       amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+       struct amdgpu_vmhub *hub =3D &ring->adev->vmhub[ring->vm_hub];
+       uint32_t req =3D hub->vmhub_funcs->get_invalidate_req(vmid, 0);
+
+       /* Update the PD address for this VMID. */
+       amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_lo32 +
+                             (hub->ctx_addr_distance * vmid),
+                             lower_32_bits(pd_addr));
+       amdgpu_ring_emit_wreg(ring, hub->ctx0_ptb_addr_hi32 +
+                             (hub->ctx_addr_distance * vmid),
+                             upper_32_bits(pd_addr));
+
+       /* Trigger invalidation. */
+       amdgpu_ring_write(ring,
+                         SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_R=
EGMEM) |
+                         SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP=
_VM_INVALIDATION) |
+                         SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(ring->=
vm_inv_eng) |
+                         SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(0x1f));
+       amdgpu_ring_write(ring, req);
+       amdgpu_ring_write(ring, 0xFFFFFFFF);
+       amdgpu_ring_write(ring,
+                         SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDAT=
EACK(1 << vmid) |
+                         SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRA=
NGEHI(0x1F));
 }

 static void sdma_v5_2_ring_emit_wreg(struct amdgpu_ring *ring,
--
2.25.1


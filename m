Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF81C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Feb 2022 21:09:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149B510E16B;
	Mon, 14 Feb 2022 21:09:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C94DD10E16B
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Feb 2022 21:08:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHR/KClMLKG0C57nH/Szvx4s082yW0dNhS03181WNdAK1baTmC/qI2q5qVsP449HYhr8TC+qU7rtf2qYIvh55XP0B/C0npME361V3U0ambIaf4grePArbXdKjYdK4mYPRZ1EoU1ESlSBC2pHe73qFXLZUj261M7Zybc+tgczpayCnKvDt0Z86E0lHT7Lh7dM2/wUrEBh69M7VyZCnOMtLhutw75iWGo2MhEI8YxnG5+L6mV+EZ96CAucwcrgx3xVYn8U2LO9tnkzPzO/dx4z0zAyj/hkNpuHXptkvJmmZL4HRl+rEII+jLQOLqSGkz/2IQPaSM8HTJpgyPptyOomjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxfahGhZ9W2QlQ9UoJMA52jkG1A1EWdu0XEU7CVxh2s=;
 b=M2aw3hwHNer1eGNfDGi+xi4PDoHz8tynaiFWN29CRm2dt5/JopWfPxNH/Awa69+4RSaV4n6IjAw6nfmU8bqrnZNPtIjvnYGSiVW3Kg8jyPBp/7Wks6vUaRsXMRwT6DrYUyyv9fQLzaPYpRkNAQ6PZrOLzVCg5MJxGiiFwyqaiwhm0Vg9Jd/EKVhhO+UwXOBnGorSeGj8kn4ojVG166yrQVK/k/jW7z6TWxe7fR1L9z7C9RBsiPet3fkuDSP4AgD0loM1M006WFFtkgGR+FoHt15W1YhJ9NOpEe8GI1qhh74bOJJxEQyZ3c6xKsIc2UpUAls/6tecz4JhXilq9tkTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxfahGhZ9W2QlQ9UoJMA52jkG1A1EWdu0XEU7CVxh2s=;
 b=nFk0RmNWW91RQNqdMv6k7+9G5w84P/d8w8qD91TIdGGP/ajLqnBq4TJ3ViXo0tlxEsLMAUwk0xhSVa8Nd5iUQ8NUveRoXcpUkVeUPQwHWp2zU6sKKoQBmF2OiAzzCb2q/G3veP5FJ6mvtfAaeqCBofKCnR1RikexLLf2vD0e0BI=
Received: from MN2PR12MB2957.namprd12.prod.outlook.com (2603:10b6:208:100::14)
 by CY4PR12MB1544.namprd12.prod.outlook.com (2603:10b6:910:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 21:08:56 +0000
Received: from MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2c01:4e44:a035:3fd0]) by MN2PR12MB2957.namprd12.prod.outlook.com
 ([fe80::2c01:4e44:a035:3fd0%3]) with mapi id 15.20.4975.017; Mon, 14 Feb 2022
 21:08:56 +0000
From: "Zhang, Bokun" <Bokun.Zhang@amd.com>
To: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix wait for RLCG command completion
Thread-Topic: [PATCH] drm/amdgpu: Fix wait for RLCG command completion
Thread-Index: AQHYGUSq5rd19t0UtkappS3lLH/yEayTm2Fg
Date: Mon, 14 Feb 2022 21:08:56 +0000
Message-ID: <MN2PR12MB29570E798C089D8BCDBEF3ADF4339@MN2PR12MB2957.namprd12.prod.outlook.com>
References: <20220203212525.12738-1-victor.skvortsov@amd.com>
In-Reply-To: <20220203212525.12738-1-victor.skvortsov@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-14T21:08:54Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7f65bd2e-5151-4039-8183-af86cb5a44ab;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-14T21:08:54Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 19e36499-8d47-49ec-bcb0-e1a50a32073c
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d9176d3-b994-4cc7-9f7e-08d9effe367c
x-ms-traffictypediagnostic: CY4PR12MB1544:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1544ABC2C2562C070EE32D57F4339@CY4PR12MB1544.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AI89DlCxiPxGPKIN/lbxWWRnf1Rn5JJnjiyztfoRWjhDxVFHWqVmsCf/v6yV9ifxy8ziG3jtBvnFBIIGZYSeJLIyywZwrQJmRuh38JYztV2pMOqdL61VikOyNRFV8AZ6y88cJQifctXmqNseAAyvmLBekqeR1FtlJdaProcbFmh5O3gA+dIttWt+bbdA5n+l+JAhKe1VElw5nHJqZvwXbFjHT1/W3kTmhnJA2/BljElnTKe4GgN+9FLhz6jo1pc7S2hfBuykCG5tuIWvs7hRrYZLCnd6G8Yr67XlNDr7CvP0R3/XaLE2yoXu7vstKjEVZ+CHWCSHY5w0oUlvLti+LH7AfyHixNYTRea9+5anN5DxNtbxne1/MVsM3qUgTYa6GwWZrLGAZ+H8ZAaqMyfUSoP8nGkYHfX7JyAkeVV/r1Y1fdr31FZOqNZrSCw7nsOw7zvn/JvSMR/wVq8HdpK9Aq4On48IoEf3Y6m8/XviWKLbm/u50VPOH7LbfSKh4k3/0fBtB8kFi5h4dRhviqemZ2eu6PkoKP95z60Sv2z9tFY21yzP0Q6r8vkg/qKA/WvRuR5R7T+oKf94XR84K3T4N1K+0szdO3BQSj0YM7ZWAXFTEwwebrNEzlo2UrdJTX4mVomtnUbc1aNrLAihVyaublVYTKXpaBOqjZOURGiYP60pPVH3docAKCMtsOl7ffRGlCyQmmngsR8L8RYHbbPcbA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2957.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(110136005)(316002)(508600001)(71200400001)(83380400001)(6506007)(9686003)(86362001)(76116006)(186003)(2906002)(55016003)(33656002)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(53546011)(122000001)(66946007)(52536014)(8936002)(26005)(5660300002)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4KPdVsPYHrrsR6hed/4C58HdN4TRmDhq6RNVN5ovDJFCRx64k3qY87vJwMWw?=
 =?us-ascii?Q?1rjQoaN0ypDdX33jwGDgoFYDhTcHefMsebXdEG2WlXxhcebUCJwvYnwC5b3c?=
 =?us-ascii?Q?adoivH0NuD67o5iq1yxsv2TqfsJjNbJVf/Ncs2ETeFnShfrBQ1qW1HDjmEHC?=
 =?us-ascii?Q?gC7zd6KqjTd1hO0tWLgii0HN49ODvxQxR+WK9vi+V1np9PIPu3eZLO+OZo1t?=
 =?us-ascii?Q?spsaq609B2GdhRCQLTShcnRoA4Ss98KQwm63P55SEqCscuO9zviWBSgdLNvS?=
 =?us-ascii?Q?JD+TWXnONHielK0if4TaHUKaJNRkq1a5S+OoY19NmbEFk/JRclLzvcRhlYSm?=
 =?us-ascii?Q?W3DY+xjOnph59gaQ+Zjf4gGRB1SnK/BGzv1JJZZ81XipxW40SFqpHUc6dNF4?=
 =?us-ascii?Q?fcZ0J4xBTpLJw5Xq13yn8atBmUfVDR/zKotBf3lDTb+nt3zalJtoZ8meGayl?=
 =?us-ascii?Q?qAFSW9gKYwOHfTEUkzhTXT5UuhVNixiItLXZlWksZDv4oPnQo3+kinNo+R3A?=
 =?us-ascii?Q?CG2vKxB2iN8jejV3mV7sLmcuamhOFTJqmiqFSH+WYSHlVxSoRVVmqH1UvJvC?=
 =?us-ascii?Q?2tf66hNTTYRlIMaIGSkbzgh+iA/7ZT0DSt36OKQEvRNM1AnGtFnc2cyGw6in?=
 =?us-ascii?Q?KucZn5rIdAo32Fsp3gkysjKfQv+Z7GBqjhwJIgFmnZSC7MPRVH04F9Dpaxtw?=
 =?us-ascii?Q?AMeaGe6p5hJhXpUJbSOC1tvtXYcQyu9Yr4nTcJCwLElRqCqkGrRHI+YlxkA4?=
 =?us-ascii?Q?j1wny6wJt7Oh6Fu5HWuwGO/YJGaFac6o7N2ISAqkwsIWszqJZ7c63EQnSps/?=
 =?us-ascii?Q?i6fnfuqnazepOW17qt2VGVGDmrOzYYiLxLZxjgDWj1C867BFRgddXmaaQZo0?=
 =?us-ascii?Q?L6DoMdWD9dRxar6aMPwyYd/qzx22QS40xHaokpA8jjrDhEm/ZtwN6GCdrwJy?=
 =?us-ascii?Q?zqL1sTmgU/z5iZRk64PKILZrJl8U2iRumJzUpAKZXr/O98ZJKjkOh0OwPTkF?=
 =?us-ascii?Q?EcE8k6cF9WPEUt8A81vKQvRXkKgQ360W/Y975Pze9zJFhA9RX5zXlqX6Dtoj?=
 =?us-ascii?Q?TNF+UPcxev7H+6zZMaZMNIIA19s+MgLqYwna5xLh/m0wZSq3Xp39p2KNilP3?=
 =?us-ascii?Q?NnKmCic8vk2TpYatXt+xQk5NYZX6rtezyzXUuNG2TqdmMKXeCI2VVO7XSPnH?=
 =?us-ascii?Q?O90IFvCItghuYGcRJlkSA2Rb/NsWWWVNEkfEMuzwtjLjHxqJUzjUDIrjPWQw?=
 =?us-ascii?Q?VPiofJJtDqThVbxQposoUIZSkfTGvhncMSgIZqXFVcE6gJ1n033qUdFcyg6Z?=
 =?us-ascii?Q?aRXl0eTVyGe/SJjc3OfE95vXlVDgmr+Bxb+z1DOyas3tCjfhE8e8y1BKDZpH?=
 =?us-ascii?Q?3wMxcQWB0rdfuBgEZZ7ZQknJoUfNHJXruTacbmSd15Mm9wvPcQhSyvRTqvnY?=
 =?us-ascii?Q?yJzlPSWNoQ8snuo4ko5tOWRg+Oc10/s3k77IvkU122JwSDG+5oJ7UD5U0mhz?=
 =?us-ascii?Q?iSq+RVwndWWmUxt0j+bW+GI6NoyTdyX9daCtMBiyoEUUHx4jXKPvlfMvrTOJ?=
 =?us-ascii?Q?Aww8PTfo7XKNNEYYCYI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9176d3-b994-4cc7-9f7e-08d9effe367c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 21:08:56.2473 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EygvIGPTjhmXWmGAMsgYwnVLRiJTr81xgFW1jyxULarfZnsKH1jt6Ro5kC2CkEU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1544
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
Cc: "Skvortsov, Victor" <Victor.Skvortsov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Tested-by: Bokun Zhang <bokun.zhang@amd.com>

The test configuration is 8VF with 100 loops of VM reboot.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Victor S=
kvortsov
Sent: Thursday, February 3, 2022 4:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Skvortsov, Victor <Victor.Skvortsov@amd.com>
Subject: [PATCH] drm/amdgpu: Fix wait for RLCG command completion

if (!(tmp & flag)) condition will always evaluate to true when the flag is =
0x0 (AMDGPU_RLCG_GC_WRITE). Instead check that address bits are cleared to =
determine whether the command is complete.

Signed-off-by: Victor Skvortsov <victor.skvortsov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-  drivers/gpu/drm/amd/amdgp=
u/amdgpu_virt.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index e1288901beb6..a8babe3bccb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -902,7 +902,7 @@ static u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device=
 *adev, u32 offset, u32 v
=20
 		for (i =3D 0; i < timeout; i++) {
 			tmp =3D readl(scratch_reg1);
-			if (!(tmp & flag))
+			if (!(tmp & AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK))
 				break;
 			udelay(10);
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.h
index 40803aab136f..68f592f0e992 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -43,6 +43,8 @@
 #define AMDGPU_RLCG_WRONG_OPERATION_TYPE	0x2000000
 #define AMDGPU_RLCG_REG_NOT_IN_RANGE		0x1000000
=20
+#define AMDGPU_RLCG_SCRATCH1_ADDRESS_MASK	0xFFFFF
+
 /* all asic after AI use this offset */  #define mmRCC_IOV_FUNC_IDENTIFIER=
 0xDE5
 /* tonga/fiji use this offset */
--
2.25.1

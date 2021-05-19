Return-Path: <SRS0=RLY9=KO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908CDC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:25:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453336124C
	for <amd-gfx@archiver.kernel.org>; Wed, 19 May 2021 03:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453336124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7733D6ECCF;
	Wed, 19 May 2021 03:25:19 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C2196ECCF
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 May 2021 03:25:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O2hcyDu5fRJ4YPlikKrYDX6Rk2bA2CYpLsNDgeoUg8RNtL7URKk3Rklq+MRTMF2aEEbmJBaLkQRofy3xEvf3Q4tvQ0Ft7JjcRxALxUOhyTIDUdlgElYaLufWaR4ZO+d803N/Hq6OZZJlJCUcspb4yrITVy4ZYmckSpMlACwzgQznOOjCkUFf4EE0cuIrhzYix8txeHIDrlbWRlrX9KrEYkb5QP3nr/GwL/AZd7vWSr43dr5zEKvy8b0JphIDxPkSnUjtYYGaGRDJRF1DmxuzmO3fSLC4aQVLgepe+iMjAMQpH8w+/8CbZSNvFHhsseFYNswcP0y2wQ93DrynWVeLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgFEhMz1svwJvTefZpbZtYQ3tJXuH+3Df3XDedmp6vw=;
 b=CQoiCpowcjQqaiz3gOMjYVGR16pO2fRiuH8OD4ntsgJsfsh/Mu/yH4SgaPTlsIg8Eek/0AplPiJjulD4Gh4audiSY6oNhi90/FmiKj+0hSR2n4SnlbwknJbk6lFcE8riRojfjfZzH9Qk9OhKGISnz1ug7CvjMPff8+wVjkk5UyyrJf5fuEmQFIijH+h27tFysZ9O/2jCxdE5+lKH6YP4Dc4G02YaVLLa1jHnWNPiIKQX87BJaoaJnYyhR5CshBPXDfD/NO4T1ZgXidxcztuOjZv2WhQ/SQF1NV2HUxuZeoDb4S+RzrxWH8GGoaiyZ2/7Uf843YWeKIoiyHZH1T3mqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgFEhMz1svwJvTefZpbZtYQ3tJXuH+3Df3XDedmp6vw=;
 b=2IRJ1g8+isLMQLaXEYtS4QajSUxKiXeaNXj9GntjSx3hJq1f7acKq4fjfL3/qtELT0DSSMrk8FgRYiJhwT69HIMYlOYW71uAG95pLt1dcpRxOGkJfmRzdwtQcD9yf3bk8+gCdjKaXm+8hVM74A2KzPFwrBhbOabKEOeQoThCDkk=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DM8PR12MB5496.namprd12.prod.outlook.com (2603:10b6:8:38::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 03:25:15 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::41bb:78fe:94ff:aba1]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::41bb:78fe:94ff:aba1%2]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 03:25:14 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: correct sienna_cichlid SDMA RLC register
 offset error
Thread-Topic: [PATCH] drm/amdkfd: correct sienna_cichlid SDMA RLC register
 offset error
Thread-Index: AQHXTF42ktcvAXCA80ed+nIL06ucT6rqJBEA
Date: Wed, 19 May 2021 03:25:14 +0000
Message-ID: <DM4PR12MB5181DBE6F5949B6F419DD4FAEF2B9@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20210519032214.44849-1-kevin1.wang@amd.com>
In-Reply-To: <20210519032214.44849-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-19T03:24:54Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=72002c26-164e-462f-8647-40e935828f0f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c70bb96f-76d6-4092-520b-08d91a75b7fa
x-ms-traffictypediagnostic: DM8PR12MB5496:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR12MB54969CE3F04615408939282FEF2B9@DM8PR12MB5496.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:462;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: arJxP7NSNHvecyjfCvtlp3p6gmSinzRU52RyZsbonsYOVKLtwH5bmjYhSWe6BJoB4D0TdtIFUSQ8WBWr0rfck2WVEf09mCZ9X0xTHsIOLuQJ1lz+VuCyJHl+bHtyIucsNm3LFOoBHYr+eJVoHJQ3/FFtxGvbUaVW2XHEthudOjQNKBjMr9HL7VNgNliEVRPpPnVUIl/Ex4Ev03r9LZUOK4HkP9tm+pe2YZEzK6YGWBx2N2eG9vsaI5ESL7yP6tMn8Vk1/HFrlRz7caxksw3RxGxH663kpYm59JHvRk72z6FadyhjZUPMEoc5Do9vOFZDGvJFyrFOilMTHU2zF7XifoXMGFvZUcdjpCm2fEBUYpV5+wjloG/mJVfmtiCMAJpYBY9H1Akju1a8SQE4qyE5TbX4EskZpxkrQ4vFx72JOCnJPVcA+pqwILxzfaqv8QHhWCo/BYAPB2c97wUwaIbFe0cL9kZH2Hg9OxmMH8NFG+5lVUqd+Gg2obWlwNyQCFuvG4Ys/JKRl1V3m4GMz7ln/yAyBqbO2OlSpceC/N9hUYH8n9uNhTYl98WhoEkbXAlPlryFwjPiNuBuZ3Sf8bYtAi1zBOtqtFlXhmNmJwBtDWCAO6SjxN2rRp084cs/VBy+wQs4KoCzIMayR3WGZaFkyA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(9686003)(66946007)(33656002)(52536014)(54906003)(110136005)(186003)(64756008)(66446008)(76116006)(66556008)(55016002)(122000001)(6506007)(7696005)(53546011)(38100700002)(316002)(66476007)(8936002)(2906002)(8676002)(71200400001)(83380400001)(26005)(4326008)(5660300002)(478600001)(86362001)(357404004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1DhorvrHftvdaVUCEeLjpxb3SgS2NZbMz7/0k9JrySQwg+gszeXbvXlrbi6F?=
 =?us-ascii?Q?A5GAyZtg7YLNqSNewhf9KfZ11XoY0mYuoFqxe4enL4jIsjVyU85Id2V2yz3t?=
 =?us-ascii?Q?YAWR0TJpYIRQ2F6c0uBppFyExRRktamqx/jZdnyv6k0IOcXTuKxsJwN4QPEG?=
 =?us-ascii?Q?IXjMcbnWZL1DGt9dHWlzBUlzZYwJT5KHL0kajYfODKiDY9up+bgkBX3G8TBB?=
 =?us-ascii?Q?B2ySNwT05QROyTTFiq11xSPtf4mFkF/40isP1Mzxm2VyzqxDh3qkwC9nT++m?=
 =?us-ascii?Q?Vd4AiDhrD9Vxe+MM0wzUzsN1/sM0UqHNwQOlFi++1Fp/gs1NUTP+ilkdSRYc?=
 =?us-ascii?Q?/QWKoP1M1FpSK9lmsDYBhsrrjv9pDV20Jr/rVhk/+ZzewGHSpEqjiJOQRTD/?=
 =?us-ascii?Q?sI2kFMfqN6et5v9q9HrPGasB7fzsbwsuulkRLrscIpslHnnpEaSRLNluLoDZ?=
 =?us-ascii?Q?0LU3aMckECaAVgXe5BjMzf15NO9V2GrdTi6FdZrmm7FBXZVlzK4x478aSBto?=
 =?us-ascii?Q?qqiNgGHviUQwhoE2LYCXJ74JzOUHTVVvkDwDBCefIoGQlhG96L3Y62DfAh77?=
 =?us-ascii?Q?NXhm5YKewNpOmGVZXO0VBZ0QHJWVMC3nj/+TCOHua1O9rE9gIwwnVlGTGnFy?=
 =?us-ascii?Q?XJ3HBLIAPuwltRHRTsRlo+y1Pa3Ncbua5VLeZ6lJ+5R06xfTZmTQvW+MMZXc?=
 =?us-ascii?Q?F6Ed0O/wcud7e8sSBAfOUAGgH5ndKrAmdyLgl7YLkn95RdAqN+yyE+gsEX5q?=
 =?us-ascii?Q?UPmHU41DB7UvaTkfuSJeReiM2MrOI0tyKGXRSqDrr+oeuBY0WyZ49QiF3YAP?=
 =?us-ascii?Q?0cD1JxClzFmVpTGdNlSVxJOBSr9yOE/SUuO8XwVZNoxpcBdksAjQuBa6167J?=
 =?us-ascii?Q?RIQcx8K8gS+UaX/nO4SJlj+OMK+MV4mWcx5I9VQx0bIWC40zfetCOgb0RQlP?=
 =?us-ascii?Q?Eq3mIM4QoeNoIpCr/EmPmNKI1SIG1XhDFolB8G17w90eQg2M2aDt6NGJ2uwZ?=
 =?us-ascii?Q?mmdPk5SGodgBzQ111NkIHvMcou+ep8/m/21koWSg+B99cBOv5BzUQCn6bgJS?=
 =?us-ascii?Q?Kx15k7JjQ5UkSbOuBWqufSez0UmuU2M/Lp2MRkze6/11Sz2i3+KMwhtXj0X5?=
 =?us-ascii?Q?YganfFZN0twLXI9TqyV0Ste++pwSIrE8T3U+xrvkwL1aQwfz8HJJTLhjB90a?=
 =?us-ascii?Q?T3WYyXEukUAC14HxK4Sht38tfeZycPNBUbmWdrMmc4Y0DCX3Rw37eP5pKZte?=
 =?us-ascii?Q?VgAT/MB0Nm6Gxt2fRvk2mDTXvaS024jpQm6b1lWG26DcP3le++IpzyBD5sus?=
 =?us-ascii?Q?i+W94tetpSkNbO9qEJNdqeKQ?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c70bb96f-76d6-4092-520b-08d91a75b7fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 03:25:14.7865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhMxMo7nRjLAYtkDDCXiTsUUkYlqDUWstw0SVb2PMyeVQNS1r97L3fURqxEHO/eT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5496
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Min,
 Frank" <Frank.Min@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Likun Gao <Likun.Gao@amd.com>

Regards,
Likun

-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Wednesday, May 19, 2021 11:22 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>; Min, Frank <Frank.Min@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amdkfd: correct sienna_cichlid SDMA RLC register offset error

1.correct KFD SDMA RLC queue register offset error.
(all sdma rlc register offset is base on SDMA0.RLC0_RLC0_RB_CNTL) 2.HQD_N_REGS (19+6+7+12)
  12: the 2 more resgisters than navi1x (SDMAx_RLCy_MIDCMD_DATA{9,10})

the patch also can be fixed NULL pointer issue when read /sys/kernel/debug/kfd/hqds on sienna_cichlid chip.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index fad3b91f74f5..d39cff4a1fe3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -156,16 +156,16 @@ static uint32_t get_sdma_rlc_reg_offset(struct amdgpu_device *adev,
 				mmSDMA0_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
 		break;
 	case 1:
-		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA1, 0,
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
 				mmSDMA1_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
 		break;
 	case 2:
-		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA2, 0,
-				mmSDMA2_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL;
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
+				mmSDMA2_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
 		break;
 	case 3:
-		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA3, 0,
-				mmSDMA3_RLC0_RB_CNTL) - mmSDMA2_RLC0_RB_CNTL;
+		sdma_engine_reg_base = SOC15_REG_OFFSET(SDMA0, 0,
+				mmSDMA3_RLC0_RB_CNTL) - mmSDMA0_RLC0_RB_CNTL;
 		break;
 	}
 
@@ -450,7 +450,7 @@ static int hqd_sdma_dump_v10_3(struct kgd_dev *kgd,
 			engine_id, queue_id);
 	uint32_t i = 0, reg;
 #undef HQD_N_REGS
-#define HQD_N_REGS (19+6+7+10)
+#define HQD_N_REGS (19+6+7+12)
 
 	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
 	if (*dump == NULL)
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

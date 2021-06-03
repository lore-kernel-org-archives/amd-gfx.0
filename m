Return-Path: <SRS0=4Sal=K5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC24C47096
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:15:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19998613F4
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Jun 2021 15:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19998613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F516F4A0;
	Thu,  3 Jun 2021 15:15:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93B266F4A0
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Jun 2021 15:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZNXsnKonNdmnLnv7yUt5C8lXDcqYlkGvjaUjXx5knbc/+9qrbSIg8SGF3pU2R7Qf16S07+hZ7xORrapFRPs/TycjrEJWfp/ykfEoNQBq+GL1VxcGDkjPH7R2hkR1nayGNde652rLoQi2a38fy0Bl8yu06FVv71dOyt89UExIH8ADs0JFdbNCdrEHzpWhTLuxwDZ2gN1K4/2Pliwib0mKoBS3w1H0Xqn4FvuxdOks7xKdHnu8WhH9z/chbNkNQ2ROx/YwD5AjEw8jERIMMGxi4+miW4FUVMwHr9cYtYhcJqYkGPvQvkYu/qotQHEjGjylQJXZXuFtqfGMZ+3gxB+3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI1l+GoU/QybKLBGSAhEqKbzGm3ZmMt1T3oEZ8B7SHU=;
 b=OaEpgNYiefOEXJa7big44/ri2BKwLImQlCAj23lxZ61yBeX/BknfPXsB+nPiWNXYo4nozLRUJCSCd0XbUQpI2jDrLNCaI3cLTN+I/DRFZ5Ej2rMdWuVr9djc8Gk94O9Gd+MoXRYKvgraS4Pn/4yaDMmqkH0PPTjCVo1WMFNxQZuD5FQ7uxDd+AI3TA2I07lxs03OcauJ1kQy0iOHZl4Zniq4wIY/xAckCG+6J6oANulu83gPCXPpX1U0RuH/+OEPHibG7uenDfPyZwhn6iGb1WjDInD5JlvuBOOjVkf5L9wQ9bftiPjX3qxY99sAnq5ZHpOKBmP0xpOLGeIAAh+8og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TI1l+GoU/QybKLBGSAhEqKbzGm3ZmMt1T3oEZ8B7SHU=;
 b=ipC4C6Y6r4pQ85uJorTaxbzIgKdxvxfhQBaNg7OOfA0IkL2JXLFw21pzd8zK7+mXw0jpj635DoDQZwTL53pyAO1CKp5aXFyMZTR6AzG48Mb7HGMn4pZ/lno0942ZNNRoeYTXNm6Wf1gtuojtiKjAEcce5LZwXv4MTgKTlozhdok=
Received: from DM6PR12MB5534.namprd12.prod.outlook.com (2603:10b6:5:20b::9) by
 DM4PR12MB5325.namprd12.prod.outlook.com (2603:10b6:5:39e::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.20; Thu, 3 Jun 2021 15:14:58 +0000
Received: from DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c]) by DM6PR12MB5534.namprd12.prod.outlook.com
 ([fe80::a8c8:ff39:a981:445c%6]) with mapi id 15.20.4195.024; Thu, 3 Jun 2021
 15:14:58 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM
 for sriov vf
Thread-Topic: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM
 for sriov vf
Thread-Index: AQHXWIKofNTtQ+5zXEKXgCLsVxOrDKsCZNkA
Date: Thu, 3 Jun 2021 15:14:57 +0000
Message-ID: <DM6PR12MB5534515D4D05368A9CBED534F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <20210603141305.2542-5-zhigang.luo@amd.com>
In-Reply-To: <20210603141305.2542-5-zhigang.luo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-06-03T15:14:56Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=df1f9e2c-ea56-4c00-8085-da23f87c8241;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b8dee3d-68ee-4546-f0e7-08d926a259a9
x-ms-traffictypediagnostic: DM4PR12MB5325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB5325B7B90D3476A53D30E9B9F43C9@DM4PR12MB5325.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B5+SkW616G+/ZnqUFk8VKkbJZXe1F8V3uv1enZmDTbF7uWrM4GKs/6kLBkPKsqoCoxEuQmUuCizHj5Es4aNJyD8zku41aVhBPt9YomuueNo3zuY/0sHNLntiz/SIgktjtULbbBIALWrWX0mRLa4hSQKyou5QL/2izJqP6sApTe3MLIo/8c5zjlE99DR5Y1n02qlRU5Lxyin8PJxxQKPHMWmWTDADMaslgiINe86wwhL7cQJlniPSDHPVoi2xe82B8e7Uyr5TzOSi1VYWeOkE+UfDqnxsrz3Q73JtDIFncpV5/BGd8zgoaFvtDQaM/RGAeJcnCmi1JQnHWqkZvMnTgFlCBuMFW/xUe6le0fVwe61MR8iM/sX5F96M389/R9sK/87msukPgMUvaruiITVdbpFmtUb3M+eK3s6DivdIECsno7CoMKcoxWWa5nPcyVWFxTSoWsRuZ91doESmx7H/eDXFPn3yGhPasc4M4mTJpN+ZuUIJdnc9ha+uLnIFNZFdt9PZ6zKvHQQfFxItfx6SwMDN2rTA6LHuAikNK6NtGglyQ6wwZ5VgPc3wMnt1roSIgUSeaTttFqghhaLzjBdXcIMmFDsnVkukIFj0BRaQFMoKEwRqnxFPb3AwUFJrvRTMnq67ePlZuNoccgRmqIfPFQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(2906002)(45080400002)(76116006)(26005)(316002)(4326008)(66476007)(66556008)(64756008)(66446008)(186003)(33656002)(110136005)(66946007)(83380400001)(6506007)(38100700002)(966005)(122000001)(52536014)(53546011)(5660300002)(86362001)(55016002)(7696005)(71200400001)(9686003)(8676002)(478600001)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9yGL5YQui1W9tmVkUyc1DhgqB7xmJgIsWQbc56hGru4QkNl8s9oghkYYwEH+?=
 =?us-ascii?Q?wSskOntFYAW94pZD4odrS1OdIgrwxmw4IQWnEqYrTE8SXyBox06x+DSl0mDH?=
 =?us-ascii?Q?toNuLBD0hIsEKgUjQRrcCcx93+fnb1alcJzjOqEHZnjhLxhZf5dSr/YSj+T/?=
 =?us-ascii?Q?kAhCQLJnlxA9gRzkp7BaMUtqbNYOddsD3g4gKqDaFJBaf2Armqdsw/ShB2F+?=
 =?us-ascii?Q?gker73zsR6EqgS6fljT+ddXqCPf4h7aPvjOY0zwaD+xFWwDgRnwSzFpkisOQ?=
 =?us-ascii?Q?nSMvrsRYT0cTWmd7ksVxms+PYrtMrT/ZhPUjoHPhlSR0I8o3EzZE5LZagJMk?=
 =?us-ascii?Q?L5i0srIpHOJRwu1hIOYtJ2eJA9ccrUAQDhFCBvs7QEIxeARBq2tmI59AMWvA?=
 =?us-ascii?Q?A3aX0mLF7ZhosPyNeREmMh4Mlp4M+AhZCiSdKBxa/+wsq5lfwB7E2gG1qCyX?=
 =?us-ascii?Q?zXh/Gr9WSGRCSroY8rNRpobpIgzeTB8ilbfbRyZhutDGNZleGaW3Y1m3Leph?=
 =?us-ascii?Q?qHIJuAQ4cQfEX+lEdtN/REffDHy2uhjnCkkp82wXgH6P6l3ehLjz3A0cNsbF?=
 =?us-ascii?Q?REglL2itaha5kCm4yAFLq4Sl0tNxRwgZ6D1e6iQ8V9JU7mQHxE4l1J4Kewf0?=
 =?us-ascii?Q?IswLG/TertOyJEVhRH6GWe22eI5eIJRYMpERcYJyyV7uFf9Sm/39XsQr4xRH?=
 =?us-ascii?Q?5lu6LSfMbnu3297+GMiKC1R5tgDE9mq1iKNC+ddQsiVWii1ntFp+rxDT+W61?=
 =?us-ascii?Q?h06DDaPqVGKnsFLql4GYudXOeDUNk47OOqrmVK77+oxUCyr/0HGk/p7qLtbo?=
 =?us-ascii?Q?4SkJpOOv2JDQ3mbJZXwa6f1XvvbypsNW9L0S9yA+N/Z+lZVg/x8Pfn47oIx3?=
 =?us-ascii?Q?1YY0QDbFYi26trLhvCA7yy00VdyHtV+0ZAXEi0RR+1bLVs6gFLQePXEoeOGi?=
 =?us-ascii?Q?fw34fDs0h2n532jg3AnZfLKgrTkT1zNIF2W+b77K1pyfxkh7aguaYHNoe/mb?=
 =?us-ascii?Q?nhixgJA+dIH+OBFitS7XGT/pnIXiMSQXWStRBW0g4GYJHECZ8vZTXgMemmgH?=
 =?us-ascii?Q?f2wpT31iEP/nrxSLFxgTRnZrOXztS1i8Dp79hCRO+AUKNyKgfOLQWmX7LZpG?=
 =?us-ascii?Q?BN1myYfoqs+okGW/oiUfbEv2aRHLWRIm5MtLUmDylmYEWbyV1U6djzSOrIf2?=
 =?us-ascii?Q?OL2ZgKvpyEhpu+Kxh+x8w2mNvbM9RSM/OEUMfZWEh7u56lu8KDnWGYw/dtVI?=
 =?us-ascii?Q?tiqtjKUBPLS+3xJX4vtB9pAIstyX4qbdnJisOx0XmGyltsL3TvsrQLFKPB14?=
 =?us-ascii?Q?li4Q1vD5lczVbRdXa0jCTsT2?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8dee3d-68ee-4546-f0e7-08d926a259a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2021 15:14:57.9586 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: togvAVRW0VZgbVN+c2whHQglBUL4+GGz8nGjG9JmuVauLfgIbXE8ffLV2bdFIYUqfZ5hIRkJs48kO0J6y8ETcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5325
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
Cc: "Luo, Zhigang" <Zhigang.Luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Please double verify whether this feature apply to all aisc PSP supported  since this is not only apply to ARCTURUS and  ALDEBARAN. 

Shaoyun.liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhigang Luo
Sent: Thursday, June 3, 2021 10:13 AM
To: amd-gfx@lists.freedesktop.org
Cc: Luo, Zhigang <Zhigang.Luo@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: allocate psp fw private buffer from VRAM for sriov vf

psp added new feature to check fw buffer address for sriov vf. the address range must be in vf fb.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 6bd7e39c3e75..7c0f1017a46b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2320,11 +2320,20 @@ static int psp_load_fw(struct amdgpu_device *adev)
 	if (!psp->cmd)
 		return -ENOMEM;
 
-	ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
-					AMDGPU_GEM_DOMAIN_GTT,
-					&psp->fw_pri_bo,
-					&psp->fw_pri_mc_addr,
-					&psp->fw_pri_buf);
+	if (amdgpu_sriov_vf(adev)) {
+		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+						AMDGPU_GEM_DOMAIN_VRAM,
+						&psp->fw_pri_bo,
+						&psp->fw_pri_mc_addr,
+						&psp->fw_pri_buf);
+	} else {
+		ret = amdgpu_bo_create_kernel(adev, PSP_1_MEG, PSP_1_MEG,
+						AMDGPU_GEM_DOMAIN_GTT,
+						&psp->fw_pri_bo,
+						&psp->fw_pri_mc_addr,
+						&psp->fw_pri_buf);
+	}
+
 	if (ret)
 		goto failed;
 
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CShaoyun.Liu%40amd.com%7C3f624a72d2574d5c10a808d92699c9a8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637583264223318916%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=4EfyfR26TENFq1%2BXlSufuOYocdCmNcdEZHyEPzAQPcc%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

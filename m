Return-Path: <SRS0=bMdI=MH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301C8C12002
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 03:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB25061103
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Jul 2021 03:10:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB25061103
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 873256E51D;
	Thu, 15 Jul 2021 03:10:24 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D65D6E51D
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Jul 2021 03:10:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E78XfDoHWI1auWBjBPn3HXy6b9pWXfLfbA6lv+Tp3nfS12azdWS/U5zsnh4zb2N65V2MMpOeDKVjrqH5CNsb+WxOahwCkiDNeTro+/X3Y7dDCMSSIthVgpKshXU26FugASSTadN/S5HacGl+7xtR5+AOqxDVMEotFjw7zTKf3im+EB31Vj20TeL5CTSgRDm38HAogSUNbslCuQSHvO9ZnjTR0g+O5VwOLI6nel6YS6iSh/wtGTOYdJpTC7z2MwEgw6pljcmG60f7rV8dnY3PfQ6+A2bOd5zbeqovRu2uilmU2MjRBVS0tLsjhgxZA4vawoHbK7V62HnIPfnZjhxTDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REJuK5YhTAJDtAISPYoTKJ/jBgADF1waq3Bsq51zk88=;
 b=GF9+nmxBsG5L1+0w4xVWn5ztpMx+RG4qvhdpWRs6TkYzHl5EAsGdjIIVhHuPeSo77ewlYlDeAb2GmyJweq6yEkJbfx74kpP0ZJ741Oa4igOe0kS4/TshdUctpfwRiueih4DwDMGsMmpP/y5zL4mSozCdIjUOOZEBLocHgCLU86S1K3zh90T/QpuOVhyMobT7r8KHrxI8JJPKYSWLrvkBqfuvrgOmk/SbZRJNc2LRPGZw6jIjIpqpF715V5w/mw0yjL/rxMu7HvNMewXSgeOimJJ61Vh1oTegF7Rrz9p/basvoQCe8BLGVnTk5webEpSWfgsE6pr9t8pDbkHQreyZ1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REJuK5YhTAJDtAISPYoTKJ/jBgADF1waq3Bsq51zk88=;
 b=COZR/QLrW+JES0JQDoRBU9v9RPkLbS6h7XKQS0PMqzL2T1qIfxW/BaS6RTIPizy5acK6ybnzF55M1F0ewKwmmTM+PSGFITQdd3dIE3zz0IXwNI7CaZFUbH1QklB23BU43CQ6OiQFOwhn25EFEYWGFpmw5JSLvj3BReTTZRtEuyU=
Received: from MW4PR03CA0198.namprd03.prod.outlook.com (2603:10b6:303:b8::23)
 by BYAPR12MB2694.namprd12.prod.outlook.com (2603:10b6:a03:69::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.23; Thu, 15 Jul
 2021 03:10:21 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::5a) by MW4PR03CA0198.outlook.office365.com
 (2603:10b6:303:b8::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Thu, 15 Jul 2021 03:10:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Thu, 15 Jul 2021 03:10:20 +0000
Received: from hr-amd (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 14 Jul
 2021 22:10:18 -0500
Date: Thu, 15 Jul 2021 11:10:13 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Du, Xiaojian" <Xiaojian.Du@amd.com>
Subject: Re: [PATCH] drm/amdgpu: update the golden setting for vangogh
Message-ID: <20210715031013.GA395243@hr-amd>
References: <20210714093203.9191-1-Xiaojian.Du@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210714093203.9191-1-Xiaojian.Du@amd.com>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b53806b1-046a-47d3-b3d8-08d9473e146f
X-MS-TrafficTypeDiagnostic: BYAPR12MB2694:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2694C89B304A3416B259F7CEEC129@BYAPR12MB2694.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEiNi7vqNcgAJrYPibnSEQ3knPM3W8SK3H9yjCU6wwZNCz32gpdhdQtcmt9A8QIPucVNLoVoDTn+jVMP7ioNrPmHEmt3z4tcjzxp/HWQEDvm/u+U5rsNIpaEFVo4R+p5vTSQfG0j0MqFkMr3aSgMiBl/NdKEN/jpn/+GfUrNwGRx6AcM3KygRORDg+v+P1Nng7DuKpjZU5Mk3mxbKxkkgGDIgvIN3OGZIKUobAZEuExH+JNQBrXJ1BSH6b9HAU3RAyfbks+FXSFXKIKOgFmPpK0Vp2wYSMeBJxdZNDRiHDLY86H26bQ+MQciOYLnzePUCrCLCDaN1KAKM60Ua70Gd+LhBboMOZv0oeGfd8XOKNOeXGuzqGBpLrEUkNPg+HHJZpuEnnPQFGHtTezWziwWGp3QPJE5oRpljPlBi5Xes54GVAiD5ECoAc3rbEOBUln43S4KjRtmUkNf4JIip1dFyaM+M6xQJ2SE/QHHVoSZHyDiyEspqNQouA87WNd1CoQpK+XU9a+nlOayYH3MjL0Qp8WSEL23LPhPHQvvr5q0BeSUpbATkqbhdq0SoWgrLMDtH07IEjYaFvVglPtIpE+52ucsjZifLXtn1qkFkvRU2r9Bh1R/G/Y/fXkfL2VB0INPtgQu6tcMVO00pj33LQT5hxB12Fa4KdlTtMC0rIFHR842GBAC6YrMuOR3wk/k56egNeezMBY+mH+iebJ+ZrFuLW+VtJ5DT44L5f84ud+Jy28=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966006)(36840700001)(2906002)(6636002)(6666004)(426003)(15650500001)(47076005)(33656002)(86362001)(1076003)(36860700001)(356005)(26005)(33716001)(82310400003)(83380400001)(81166007)(478600001)(55016002)(4326008)(82740400003)(16526019)(336012)(186003)(5660300002)(70586007)(70206006)(8936002)(6862004)(8676002)(316002)(9686003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 03:10:20.4376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b53806b1-046a-47d3-b3d8-08d9473e146f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2694
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 14, 2021 at 05:32:03PM +0800, Du, Xiaojian wrote:
> This patch is to update the golden setting for vangogh.
> 
> Signed-off-by: Xiaojian Du <Xiaojian.Du@amd.com>
> ---

Reviewed-by: Huang Rui <ray.huang@amd.com>

>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 705fa3027199..9144836798c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3383,6 +3383,7 @@ static const struct soc15_reg_golden golden_settings_gc_10_3_vangogh[] =
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE_2, 0xffffffbf, 0x00000020),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSPI_CONFIG_CNTL_1_Vangogh, 0xffffffff, 0x00070103),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSQG_CONFIG, 0x000017ff, 0x00001000),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0, mmSX_DEBUG_1, 0x00010000, 0x00010020),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmTA_CNTL_AUX, 0xfff7ffff, 0x01030000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmUTCL1_CTRL, 0xffffffff, 0x00400000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmVGT_GS_MAX_WAVE_ID, 0x00000fff, 0x000000ff),
> -- 
> 2.17.1
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

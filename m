Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD9EC5519F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 03:36:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2004920738
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 03:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vmPmAZN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2004920738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C14989993;
	Mon, 23 Nov 2020 03:36:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CEAB89993
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 03:36:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+XMb5JpvFQXxihsVtnPuxGZjxac8VeuwUK0Y984GNL7KSQd/4PBTStgQvVEGpj+C8jHHZ2A+6MhBvZgBdzqnbE623xmyupiNMcLg3x3vCtf1J+ewSqfwEHsy+OdkWJbWQP72Pfa+mkglvO1//EOK0QpmL3oym4J5p0mhgNJnLVBJ197Cb3Cnja/nIn8/WOgjjxA3+MNvQyqF8ejfIzWspUZffS35Bn4SGgZNvVlVbtNsTGZv08nu5w3IHpL8dpASu8ofN35PieTgrfaDln8WpKgZVRWqzZ12gax8DScRnUzDtqBNHh4Nb/4lMlrjNDpPKYlYcmSBG2fhJ6c0/scnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ls3f91YkMq3DpEKSqCPdjfc3eW42vxGm54OKylb1Dw=;
 b=hsx679zBDmYTrcRUJm706vcbfyZI4QyYAdpa8BsjTXP5MmvYmg0nHmlUBpCFetEmZOw1v8ROQUJBsgoWExafww6GMCbOo7v+g37AoNyWdozT6t9SzGvaZ8wLHhP9o5iENabXv13/tP14bnEKbDiub/5DBTCftydlPNnn/yKj38VswWRZRnuzyJnKxbhUbaNKRQZUGneS20nkspEskFSUetx9jC4kERG1Y6yRHJfRQ+FHwxm9RaEELPftqshHW+F9RGok9lkbmj59CibKlnmV/WM7lzgnAj7+SO9wVtVEe1MDe047/QOPC3BNl996llW4VJxP4IaL1JUp2urnMSljhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ls3f91YkMq3DpEKSqCPdjfc3eW42vxGm54OKylb1Dw=;
 b=vmPmAZN00ey4q6Jebh7txaKSXdMYp9t/plr4leAlP02U3K4pwFMVHQhKj4+EnQcd/0W2sSPqMj0TXwHVzU3C1xCwmJ/uoTa+SzGquWt2Yz9mX5wULjX8U2nUoU9vRQxs94UKFx+sqfbV+DKaSgvyGlWPAk0hI8I9dmn4+wFi9RM=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BY5PR12MB3665.namprd12.prod.outlook.com (2603:10b6:a03:1a6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Mon, 23 Nov
 2020 03:36:36 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::617c:f1eb:fd73:b236%7]) with mapi id 15.20.3589.029; Mon, 23 Nov 2020
 03:36:36 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: update GC golden setting for navy_flounder
Thread-Topic: [PATCH] drm/amdgpu: update GC golden setting for navy_flounder
Thread-Index: AQHWwUiGcLct72LY8UCQoAfoS+Qe06nVEJQw
Date: Mon, 23 Nov 2020 03:36:36 +0000
Message-ID: <BYAPR12MB2888B9646990B966769D3529B0FC0@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20201123032652.185547-1-Jiansong.Chen@amd.com>
In-Reply-To: <20201123032652.185547-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-11-23T03:35:45Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c59a9c02-9649-436d-b3d5-0000348e4f6a;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-11-23T03:36:33Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: c44a4788-7e59-4f0b-89f7-000056fe9719
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.169.125.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3079f9ce-1172-488e-c384-08d88f60fb2b
x-ms-traffictypediagnostic: BY5PR12MB3665:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3665ECC0D68AA0D6D2551E1AB0FC0@BY5PR12MB3665.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:386;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mNWW95JJwKoKpG2ch0q53sU8nKBgf4FlxzCTszSLryanWM2qGLyzlLGehs/xAxCAR/A//QQnK33dSVbEGk+RVdDFApapv8QLFwdEY00Qgja+d9DkRt0DdORglxVC7qBxli2v7nhMbRBSWbp4hup+iRj7LY+4ZGcXIe+QHigZ4oaIuJmNoB/SSRvtSEsnSFeuiYggbUqO69bEcKLFr529ZqDJ3qxbUru6ltIX3RvSz9+ettb3OQ2cWdtyzXEm7l7a7Av5morMOFgIwUqFbmpuRxJmEXCJbW+7Xwu+uUq8tft5Y9Eo4CUd2tG2fvF4NfilEFqSVCrjjGv9Lz1F8Y4j9g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(478600001)(15650500001)(53546011)(8936002)(71200400001)(33656002)(316002)(5660300002)(110136005)(186003)(52536014)(83380400001)(8676002)(76116006)(66946007)(9686003)(4326008)(55016002)(7696005)(26005)(64756008)(66446008)(66476007)(6506007)(66556008)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: LBj4uzPvPcryiWPEBCUA27KndpoztX4IVs4C9+2PKLhW9d5UaMbMLLISt1GVts17VBwOWJVWlJL2VGwRlumVrBFpL0cUXGsiBhDimsZ8RClJg+1Zo5Fro/cmAR1dXo6OBko96r2egwv+59RYftVfk0y+aZyto1AKGlZ19fc+o11C126wpXXIevVl55LurRlxWoIVs9mSMOglz9llR4ALWRbe3lf350Shtr9UcYJVRssgvLMtumWWlt6J25Lxu1K2HGZurfpvmKICGfr7bqEDPcMMfNkKnSBIF2w3dAaOUmgGGWCHVvPJXfuOKgD86XZo25coimYPHlGHzpm+f0jdpZvB2ivkjZX9ZKrhYSeG4HkZCrGg7tXsLGfYZU50W/YWXuc8pDNWeXXbRDwK99QB4Qw6jcKzAeA8zZ/Jw+4tqitSePgv8bUU6TPuxfaCxYkGj6YMGH7NyaxdAjNm6N767Ur39ny9w1+UVkFdlz5GOhMrNmReS+o1+N/qA52xEIVqwZxUZL7a4u3WaAr09eUVGNEUwJmN03SO3G2frEk/7r2R8VCRLed2Hs0sdJbA0Km4YrkbdCivSMl6tN6eh0fh8WfAeGW81j9GsnugvfzBELCfsm0b7+pjEI+8beM63EydyaLFnRF8EtGRovkW41Hekg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3079f9ce-1172-488e-c384-08d88f60fb2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 03:36:36.5187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIr427WN7kZwTw6j8FvAYMXDEH8JgBufzuqhQsIZ61quNItyWgKpHHlXheh5mWEl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3665
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Monday, November 23, 2020 11:27 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon)
> <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: update GC golden setting for navy_flounder
> 
> Update GC golden setting for navy_flounder.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: I25d5afb46ef9667a65bc897dcddf54390891e90f
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index eb05d1bc194e..841d39eb62d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -3191,6 +3191,7 @@ static const struct soc15_reg_golden
> golden_settings_gc_10_3_sienna_cichlid[] =
> 
>  static const struct soc15_reg_golden golden_settings_gc_10_3_2[] =  {
> +	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_CS_CLK_CTRL,
> 0xff7f0fff,
> +0x78000100),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_PS_CLK_CTRL,
> 0xff7f0fff, 0x78000100),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA0_CLK_CTRL,
> 0xff7f0fff, 0x30000100),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmCGTT_SPI_RA1_CLK_CTRL,
> 0xff7f0fff, 0x7e000100), @@ -3199,6 +3200,8 @@ static const struct
> soc15_reg_golden golden_settings_gc_10_3_2[] =
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG4, 0xffffffff,
> 0x00800000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_EXCEPTION_CONTROL,
> 0x7fff0f1f, 0x00b80000),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCR_GENERAL_CNTL_Sienna_Cichlid, 0x1ff1ffff, 0x00000500),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCUTCL2_CGTT_CLK_CTRL_Sienna_Cichlid, 0xffffffff, 0xff008080),
> +	SOC15_REG_GOLDEN_VALUE(GC, 0,
> mmGCVM_L2_CGTT_CLK_CTRL_Sienna_Cichlid,
> +0xffff8fff, 0xff008080),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGE_PC_CNTL, 0x003fffff,
> 0x00280400),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2A_ADDR_MATCH_MASK,
> 0xffffffff, 0xffffffcf),
>  	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGL2C_ADDR_MATCH_MASK,
> 0xffffffff, 0xffffffcf),
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

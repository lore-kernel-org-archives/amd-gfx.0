Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF423C433E7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:33:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 433AD2074D
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 03:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XBnr7hBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 433AD2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8320A6E1A3;
	Fri, 16 Oct 2020 03:33:09 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB876E1A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 03:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6uF9FiMagl5dpZrxgFRm70v3cGZaLleejr7/AjQaFEpNyuu9+uLjboWHkkNz0X4px0t1DbRPlipbKb+ECTTpNCAM8yKHmvmgZe21bD7OhxmHwsDakHiYAcHowjeCk7TxU6COTB2dpgRsZDywfkF7/V/zTStYGmsQNMeEZfzG4vKDPAdBnf7xEZ3rjvswq9R3cfqDhrtGWmyMGxwoKz5LxoZREq5dTAEp9eKWhWrBuMPL1Ah8Zpb974RwVsdaGqnOxCgnHpNMcYD3pVIzM1Pn2rOZmmcftxHZLaVO+dxklBcd0FyqyQzka5ykjLY/Cp6HPXsL/RCM/t3YDlAKHMYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k3JXAgM10t0LY2eEHTmCaUsFUf3OBQCDuWuuMdhxyU=;
 b=Esi9otJ/Xiru819nyVQ31mVkUvcPeFoIUkcNpmyhNTWyKgHSgDSb0IsyczxndOU2GjDOAPrj4r5Y4enasnobaquZ6mc4OKgqAQEkuyVFa3ZnSwwM2VjpGZPOQDKCS59h5/kAHCMW31NN8yETEA7tiTUzoCpa4CshPixJJKFuBKNZStLQ5ZGXyTT4dE2HwCl1AavnhdwKHFLIz4dJun8cwl2TqdwO4ggYk99IIsu3JdQBYTTarpXmf7BUqZdssqCgpWERRErO1CiWRguVW4HNiXs+RL89dQP0tzWP0lAZ/ih+osG//hIT3UB9ptKx67EtlHQLVfJ8sKYVcaSzPPN3xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8k3JXAgM10t0LY2eEHTmCaUsFUf3OBQCDuWuuMdhxyU=;
 b=XBnr7hBA2BIhUAdoVY7e+4o6dnxwN4/SDkdPQ9zsAaWy6Rc9md5brvwt6OsfEX9M90O4qr8jVUsXyoSz8vj70Lo4PHdZ87wGFWogArCxanHd7grENtUXxzI95l3Mm02hZRC0OZwwlAOuLaxbyyL6g5uFlezQ8DZ6VSfPMINkRDM=
Received: from MWHPR12MB1854.namprd12.prod.outlook.com (2603:10b6:300:114::19)
 by MW3PR12MB4572.namprd12.prod.outlook.com (2603:10b6:303:5e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Fri, 16 Oct
 2020 03:33:06 +0000
Received: from MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826]) by MWHPR12MB1854.namprd12.prod.outlook.com
 ([fe80::5930:79ab:d15c:2826%3]) with mapi id 15.20.3477.021; Fri, 16 Oct 2020
 03:33:06 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/swsmu: Add missing feature map for sienna_cichlid
Thread-Topic: [PATCH] drm/amd/swsmu: Add missing feature map for sienna_cichlid
Thread-Index: AQHWo2tSvcvpfLmAzE6G+rRazL8er6mZksLg
Date: Fri, 16 Oct 2020 03:33:06 +0000
Message-ID: <MWHPR12MB18541EA7E286CCFBF0FAE7A8EF030@MWHPR12MB1854.namprd12.prod.outlook.com>
References: <20201016032004.16843-1-kevin1.wang@amd.com>
In-Reply-To: <20201016032004.16843-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-10-16T03:32:50Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=857e74a3-03a9-4228-a884-00007ebb7bf3;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-10-16T03:32:50Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 2513f6ff-f3e3-470a-8453-0000115bf6eb
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af31721f-a2c2-4a48-e8b2-08d871843247
x-ms-traffictypediagnostic: MW3PR12MB4572:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR12MB457237B1A1EDD3DAA50F5AF5EF030@MW3PR12MB4572.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:635;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJGPIZQoG5Z7KzBsSckACJbQgFURLMWHeWZx0o2P49h1OSUoffmck6wHy/v5B/I7eHeohyWMrpr96UaULuyvjt024Vp/Btyj3zd8mMMvgSCuvON6I0nsgm4LhTFcOw4uubC6cJJ/5PbfC+Ec9j6YMp029HvRoIn4GgkoKSvEQ5EdJBU6/Q+vEbKzn+rCPLfcRapCG/kr+z+lESh8vZlcuxa9Upmdr/pKSuKp9QJ7eXaIUOUc0oT/eZG5iX1xTT3pv+wuhIU1nFWT2Q5pQfLyegTOkvJpSp0O4Um8ru7Uo9wfuVnr4USbRVkUgFhj04KuEBvOpfY0nBz0cyk4urzqIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1854.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(478600001)(66446008)(83380400001)(66476007)(316002)(76116006)(64756008)(66556008)(66946007)(5660300002)(2906002)(86362001)(8676002)(9686003)(110136005)(4326008)(7696005)(186003)(55016002)(71200400001)(26005)(53546011)(6506007)(8936002)(52536014)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: FACJA0+OVCv28K5ilFE1FQIFYlJSYlcp6KeyGXHjUcyivuwZux7pHYkN4kRVZ9GHzXWTAQFlOFJ1Wq+Aabe8lwfh3ftciodqQ8WmlRPeIku4e6Fx3nFJ/757n3XWBIl9HB1g6djmwkhB7/h3zA1TIB6XP6aThKrgfqosDTrMvZLUTjoYeOpnH8w1WNBz/tqJhNmjb10bGf3j4PMkCODi9Xt0k2ozPsIuAFZ7ZE0DWVECFtwYWoInHtb2bzpihmJEQvsV+E0J5CtXCJw+fVfHPAzI9skAHgrII2zd7yX76cLDkHf0nPBpPqDJco5iM6M1BZJFNiW8Rgs4CFEczmCG4ACWN92TY/2AWxrpY78H0MGAhwS1r94IgrmD//MpsqVRyzj45supDa7WMsG+iHAOLX3HHSCT+MMVNNRwUTtHZxHUIBF/QxVRHBV0/0aOXdXRF6J1XE6jClwnKDXU520VbdDgDfHKRhN0aoTYoOJV3TlOjSrefpImdXqa82KsKnztnrfBJe7fg4xOJvHBQnsfjW1p9/irHS8kYR95xqceSRHtP2AEBdd+VaXZODSYrjiV6+wJzG0abhP3QjVn3b9f4bc23B3czkfeQyrvyBUk9mQnJxyTeRGFRI9pAB90RrfIqM6AGXv0X90+a/U7Qbe+Aw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1854.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af31721f-a2c2-4a48-e8b2-08d871843247
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2020 03:33:06.4431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb5Q+d6PO/jRKLWmNQmmZgL9CZWXprUoKJBsKHdcL5q6yrHTaa9q+QTPRkFihrgn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4572
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
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>
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
Sent: Friday, October 16, 2020 11:20 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Gao, Likun <Likun.Gao@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/swsmu: Add missing feature map for sienna_cichlid

it will cause smu sysfs node of "pp_features" show error.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h                  | 1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index b1a18fbb7682..85ae724c66d7 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -227,6 +227,7 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(DPM_MP0CLK),                    	\
        __SMU_DUMMY_MAP(DPM_LINK),                      	\
        __SMU_DUMMY_MAP(DPM_DCEFCLK),                   	\
+       __SMU_DUMMY_MAP(DPM_XGMI),			\
        __SMU_DUMMY_MAP(DS_GFXCLK),                     	\
        __SMU_DUMMY_MAP(DS_SOCCLK),                     	\
        __SMU_DUMMY_MAP(DS_LCLK),                       	\
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index c27806fd07e0..ca2abb2e5340 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -151,14 +151,17 @@ static struct cmn2asic_mapping sienna_cichlid_feature_mask_map[SMU_FEATURE_COUNT
 	FEA_MAP(DPM_GFXCLK),
 	FEA_MAP(DPM_GFX_GPO),
 	FEA_MAP(DPM_UCLK),
+	FEA_MAP(DPM_FCLK),
 	FEA_MAP(DPM_SOCCLK),
 	FEA_MAP(DPM_MP0CLK),
 	FEA_MAP(DPM_LINK),
 	FEA_MAP(DPM_DCEFCLK),
+	FEA_MAP(DPM_XGMI),
 	FEA_MAP(MEM_VDDCI_SCALING),
 	FEA_MAP(MEM_MVDD_SCALING),
 	FEA_MAP(DS_GFXCLK),
 	FEA_MAP(DS_SOCCLK),
+	FEA_MAP(DS_FCLK),
 	FEA_MAP(DS_LCLK),
 	FEA_MAP(DS_DCEFCLK),
 	FEA_MAP(DS_UCLK),
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

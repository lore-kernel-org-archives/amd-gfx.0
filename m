Return-Path: <SRS0=wluJ=EK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FF1C2D0A3
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 10:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AAD206D4
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2020 10:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="RIRQFSG3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AAD206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618D06E992;
	Wed,  4 Nov 2020 10:31:40 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 990CC6E992
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2020 10:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/Mrp57X+7wWjSQI0XFxz1GUlwE/E5h+ElMLFcZkxlP/JUJFcFQAG+V2PrqthG+puTE/bH/3hsQZc1YaTrmLmiNNCksPokWD019gs4jjVOYqCFTFkGs+awujkEIASQxr3Vv/7T+KKTpg81nIA7kpmGtgvpk5ow1RL+dvKGSg93lR0d8TcgYTLFGSYiEO12BllJyZnFdlu/17aNZVQf+78TRSOOSZfWImIlx2diROsxlOV2YrPDQDUpOAahIof+qq/MZj5LiIlCst4hZs8QjHq5Nl8rALyTdB7YvOLmAifUdKeUuFjYWR/evEmLzGdlKW7Gd0GI2Clti+ELkGwPpuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL9clWAGWxa91IdhRnrU0BNwy87J7BrCGBy3IppIc0s=;
 b=WWtCrUj+D7A3BwWV/A5NSGawrBkOlK4Ye2LvsRBnlUpeAfwrxrboBvayvqeG2L9a2X0QrWcygqd88WUD5pfkP7Pf0/ILnn1/kpQ4DXmcLAT0z7fOxq4aQ+ovVcH4K0Z+PX+3RxTY4J3HsHxrVmNUgxjEba2dNlZezYWcWgQibDJtdMqtCoqFIZHggxfdB7h98OoXruDEa5U1xIobPK6Vfyk9H18iZgjQRtW9+gT1vNYF2Gs8ns/hhU2il/gdpakruOKFoj/5tQI2bWUEER4jxtz+yb+HuCRxvsclEGAo94jQCuaQrWi5zXfNYt0Go5v1tWsI6rd26Qau3Ensyt9eGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sL9clWAGWxa91IdhRnrU0BNwy87J7BrCGBy3IppIc0s=;
 b=RIRQFSG3qkgqfO/EqPb8uD+eGveK1M5e6edKvt0VgKqmyYFg/I7QHoSZP0cXLrlAXlKSy5+L7OjHquLp3q+ebTnrSD3WH29sqGmUvV1wf0KVYR8Dytw2m8yQs4bFHJD3zy/rju+GMtFEsTCkR6M/YHCZqTeAboNVkkezRUjR0Ao=
Received: from DM5PR12MB1657.namprd12.prod.outlook.com (2603:10b6:4:d::21) by
 DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.30; Wed, 4 Nov 2020 10:31:37 +0000
Received: from DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf]) by DM5PR12MB1657.namprd12.prod.outlook.com
 ([fe80::c166:6167:91e7:bdaf%6]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 10:31:37 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add missing clock gating info in
 amdgpu_pm_info
Thread-Topic: [PATCH] drm/amdgpu: add missing clock gating info in
 amdgpu_pm_info
Thread-Index: AQHWsn1OP7bynozQCE6v9mVZFVpLNKm3xk1w
Date: Wed, 4 Nov 2020 10:31:37 +0000
Message-ID: <DM5PR12MB1657CA4D152F2BF625F7C4098EEF0@DM5PR12MB1657.namprd12.prod.outlook.com>
References: <20201104073533.26365-1-kevin1.wang@amd.com>
In-Reply-To: <20201104073533.26365-1-kevin1.wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-11-04T10:31:32Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=800e7392-a4b8-4933-9fde-000063cb8ac1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-11-04T10:31:32Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: dc903ba3-7533-49d3-a33d-0000dfdd92b0
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5606e84c-81a2-4936-b08b-08d880accf52
x-ms-traffictypediagnostic: DM6PR12MB3020:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3020D9BC330636A7F58D3F628EEF0@DM6PR12MB3020.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzUmMX0vG2aeAIM6aejKqR6CEtG8K9Jhx/VlhAV0AxPbh8XuDtJHghokw1bJLeMKIFVKZMMAXVNUpgspvdPJo/5al/b7aZBQUBBife6Swj/xZBO/G2CEMdM0W5eIXJjvPiTU+SdLvr0l1XMkhCc1oxAiy5Ec8pnadDNgoI8gicHzuJYBtHcPfVl6SutvH+Ck5U9i0pQ24Cud3KCD8KP/emmtCTfTjlcJEvjIcXqWn0N8uIAIy/+11V2VXpP57IMrA21xlFt0vbRnnWBsdzClxyjWgFbhv9ZFUXIF/aZxP9/Dz/cF+iyKHbo98mGfD/LTrhAjntad3Lq6LvGnMSAMe/fFAaCtbndSBipejCGUUB0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1657.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(83380400001)(316002)(5660300002)(52536014)(478600001)(4326008)(966005)(110136005)(54906003)(76116006)(66556008)(64756008)(66446008)(66476007)(8676002)(66946007)(45080400002)(71200400001)(86362001)(8936002)(6506007)(186003)(53546011)(7696005)(26005)(2906002)(55016002)(33656002)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: klqygAGNIFKuGN1WE3uXOEBVWFMvx1gxlwE0VdrIOEREK0j0erpEID16Nk52+Fteo0rhFn0WQlKWjY3hN8D7xny8NY+w+pVP2/JOjsm832XkstmoxcdLD0mg7QmWV8aJ7sT4m/U/5EmMnfc00/9as/YnGEMQ/eEMvWuHsCu946jtlDdMwRLifdZ2nBcUdX8JzrC3B3qv1NgwoaH9GOIvS/AaZ1WqpooMYQ6fmpLQQ55QU+pA7k7E64GkqcL6JKHYpv4XYxya/LhvtL+GktmtZwUfFUdfmTNdQ5lb8M+e3dzv3xUUdUD4RcAv6TU8aO4AIOseJHt3KSbgmiA0XfRqajyxNgOWfo1eBfkPmEFlpQYScajlVbvET+Hvd7Vjo3k44FDEcWNrPROk7NCpeX4GQwZoumuL6nEzbZd2DxQlYGNJFjch6B7OnAwlCo3zrHiyEwfge3+Z0BYlPQdaDh4qyok9S6N2GIrxe9WWKbBQUO5/S+6191GkELezxO8zmgK6wRKvXyFIhA4FlAbZmrrYNJRnFyv/vrBd0qyvE/6HTTF1bwyZt9AIQO7ARMyq1YnZ/ZYaS1oB5NgNKIQaQcEW3v8ObhYeEP/qNdQIvXSPqLups7SmdscMnZmnh/IISQ4vLJY3PxeaZejOgxbYuW5+FQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5606e84c-81a2-4936-b08b-08d880accf52
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2020 10:31:37.3198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iSt07DGme1GOjvYsB3b1dROfDXXCh98bJ9MuOFBrmoOQaNjgk1X909hpXPsH56uh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wang,
 Kevin\(Yang\)" <Kevin1.Wang@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


Best Regards
Kenneth

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Wednesday, November 4, 2020 3:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add missing clock gating info in amdgpu_pm_info

[CAUTION: External Email]

add missing clock gating informations in amdgpu_pm_info 1. AMD_CG_SUPPORT_VCN_MGCG 2. AMD_CG_SUPPORT_HDP_DS 3. AMD_CG_SUPPORT_HDP_SD 4. AMD_CG_SUPPORT_IH_CG 5. AMD_CG_SUPPORT_JPEG_MGCG

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index a33b1cc50008..7b6ef05a1d35 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -64,6 +64,11 @@ static const struct cg_flag_name clocks[] = {
        {AMD_CG_SUPPORT_DRM_LS, "Digital Right Management Light Sleep"},
        {AMD_CG_SUPPORT_ROM_MGCG, "Rom Medium Grain Clock Gating"},
        {AMD_CG_SUPPORT_DF_MGCG, "Data Fabric Medium Grain Clock Gating"},
+       {AMD_CG_SUPPORT_VCN_MGCG, "VCN Medium Grain Clock Gating"},
+       {AMD_CG_SUPPORT_HDP_DS, "Host Data Path Deep Sleep"},
+       {AMD_CG_SUPPORT_HDP_SD, "Host Data Path Shutdown"},
+       {AMD_CG_SUPPORT_IH_CG, "Interrupt Handler Clock Gating"},
+       {AMD_CG_SUPPORT_JPEG_MGCG, "JPEG Medium Grain Clock Gating"},

        {AMD_CG_SUPPORT_ATHUB_MGCG, "Address Translation Hub Medium Grain Clock Gating"},
        {AMD_CG_SUPPORT_ATHUB_LS, "Address Translation Hub Light Sleep"},
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKenneth.Feng%40amd.com%7Cff0f8c1785f8400b57fb08d880944564%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637400722295423196%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=wO9U8pnZDeq8%2BTI4wdXlnJpcmhDM79MFV%2BDgJKOCXyk%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

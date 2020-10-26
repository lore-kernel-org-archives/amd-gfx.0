Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441BBC56201
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E691F2224A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 15:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T+2YUn9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E691F2224A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FAA6E95B;
	Mon, 26 Oct 2020 15:09:01 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2058.outbound.protection.outlook.com [40.107.100.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 800E16E95B
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 15:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2WtVeBz1o6yWfeKyiKQ4g3bRXfED70V/2dJfckbFUyuwBJhPTw51xRqb1WEHnuxeNEPdDqaevHPJtGtjEkIFBk9IfckeeaCkSDvCYNt6sx5CJ5fbiEs5gkkDWYZKqwF/OZ/+UEgrRGbClfrmU+BME5g9vPUMi/E1IrTt8glyJNsve/rva+8AHab5YA1T2Uve3gsyQPCIMk9N/JVi3eYXkN4eT7ivGEIMBGnWjU6yJKHwmO5G6Orqyi/RjuvBO8rDUyE0gpcREkuq53Zefl7+yU7/9bugO+msQGfkxDONf4hTMGl+yiP9uFcoQ696DGzuryTsyenuh4bULy9pB60Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlkrQeyI/2/f/kqF24TYu3Y5v/Ka32H5CGI3VnFejT4=;
 b=etCh07YoyVAzMBEBNheEGp0cV9/NfFsUXbJI1GA//HnJmWJxOtfheAPuNKJF9XNrjhw5BlZjJI0W/NKDe9RhzcJse2/O9fn5DX2yvtuOFhVLp2ct+CuHKUWQWGJQzii10EGWR09QRwORWtGxg3/CbaSDQE7Xwn4hLSvDFa1QVNpD/y8VVcMhuSRmDaHrFnwQKm9rcruVeC7IPFlwhU1eLza8vJOM7WzG8Y9NPv/j3c2L39pnJYZ3iBIE9wihkuY5GKLq217aaiLsuthwse03i+MoLxLHw96ka2c4jCkmRBnsy1TZSYLc5LuQLil5JLQxhaozgIxWFUv7iSu6Sbx0aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlkrQeyI/2/f/kqF24TYu3Y5v/Ka32H5CGI3VnFejT4=;
 b=T+2YUn9vqpkDiiehnbPq95YpJ14mHUd0K85NTqGtviiZlRJufWjiVV1kPx+YPL+kWX5tScasSlrzpvow2vu6VeX+alPC4EDWnOZi72RwkfxgnZf22mmbeoX4i0+VScUoG5EHWBvzB1SDZh2AeLMEHwtT86V7EtWXmYVdxwNeAlY=
Received: from BL0PR12MB2433.namprd12.prod.outlook.com (2603:10b6:207:4a::25)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 26 Oct
 2020 15:08:58 +0000
Received: from BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::8867:11f7:90b3:1627]) by BL0PR12MB2433.namprd12.prod.outlook.com
 ([fe80::8867:11f7:90b3:1627%7]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 15:08:57 +0000
From: "Chauhan, Madhav" <Madhav.Chauhan@amd.com>
To: "Huang, Ray" <Ray.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: add vangogh apu flag
Thread-Topic: [PATCH] drm/amdgpu: add vangogh apu flag
Thread-Index: AQHWq5bcigmQvhAmk06lSXgPg05DcKmp/D7A
Date: Mon, 26 Oct 2020 15:08:57 +0000
Message-ID: <BL0PR12MB24330A458D668842A46C99269C190@BL0PR12MB2433.namprd12.prod.outlook.com>
References: <20201026125152.460802-1-ray.huang@amd.com>
In-Reply-To: <20201026125152.460802-1-ray.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-10-26T15:07:44Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=04a18765-7bdc-43e1-8e87-0000dae8d55b;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-10-26T15:08:54Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f6d30feb-44bb-4214-a614-0000facb28f5
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [122.179.124.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4e9d38d-f313-4e72-5af8-08d879c11028
x-ms-traffictypediagnostic: BL0PR12MB4865:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4865A7C174F6EE9F6BF3F2C29C190@BL0PR12MB4865.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:294;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iUKrCOwkdJBXeGUYlTjaQduW4a2DhS1b8rASlC74prutX+0WSuQ/EQYgR+s7QXv3pfsyYr26pqvuutdBc7WK+uuAxqfeymySLI6/0WujbLtCPNGy3ZWYQZ7j6VtxX8FxgO0aS2kwpeA9LsHoO/+RLlSTkOlsK2Gu6ZfEvjXehEQBT+X36fNSMK7314wTHSnCVS4EbYDm9XTXEP1mNI8MvOvJCGaW2alxWhXdugf3Mtx3ylYSEDjr2Z231oMk4tCWc3tJ1MgMo+zVgrRO/VKUPV7RffXAjS5MFXobGNU06FILs7G7Ac3wLwQoesFr0byWgMH9CG3K4kQMSRxK7Ap5LYSC3pTP97BhwECi3NGlmcs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB2433.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(396003)(376002)(39860400002)(5660300002)(26005)(66556008)(53546011)(478600001)(186003)(966005)(66476007)(2906002)(7696005)(55016002)(64756008)(52536014)(76116006)(66946007)(110136005)(45080400002)(6506007)(71200400001)(9686003)(316002)(66446008)(4326008)(33656002)(83380400001)(86362001)(8936002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: yvcroAWDd8pziV80+gVvVRvh1IjmYWO4BrNo8+d6Cz5/9U3hMk2iuYeq5eIStSrhU61YUym5xs6Hjz5YwGcGbEHbwaI8Ddnnup8pKpn3G3EINTU9XENmVWwJ3nMvaBDAZFtw5vvuAbsmo2/tO+6+z4qprXVNUOGR7ugoqE8hV76wLReA1V5GlEJIuEu++AS5Cy/454psordaWwSjlLnDWFR+XXpQXrpLmT2PXtly+Pa+z/XLx7nnQtN4iYjGeg4Zs6UfG7/G+Cp3aoTjNnhi5R2jHV15FyxnuV8YwzdjYz/HA+4p7Z+7ql5qps9OnbdyYbzh/9fHHXSACJeCU8iuqVBQCo6w7tOJhxZPnvl8rxloVo1enaJArFU+YY/zXg9T+meW1BACY9vNrfLC6Z21EAsTFYJ1zmzO3qkvWfDNPBqpk4J+7HeX4fl40jn81trxZtuccRKhwmxtJQOn7RckA9N2LFR8clUxdGCYXa1q45G9VPRD86MJe9RDzdljq6FSbaGY6DVfYdj1BxP9T3BrxK8odSJybqkGNbqrTL7YqJwQRNw/qnKCVV2Vhasc1RQ3VFatJxYLc+lC5sy1W0WigMTGwxhpzZyEgXjNGcITx1vIOT9KrUCwa2EKnZhG2AvYjIaEzQYaVBnFA9CgOq6ZGA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2433.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e9d38d-f313-4e72-5af8-08d879c11028
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2020 15:08:57.8295 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DbSQmJ1GPB/XBeWqHZ+Z8Tse5/oqhFGzWNxuVbv6TmC3AL7v1F5bzqG0hbLO128ylLk39L2gdJEVGrl2VTZMzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: "Huang, Ray" <Ray.Huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Huang Rui
Sent: Monday, October 26, 2020 6:22 PM
To: amd-gfx@lists.freedesktop.org
Cc: Huang, Ray <Ray.Huang@amd.com>
Subject: [PATCH] drm/amdgpu: add vangogh apu flag

This patch is to add vangogh apu flag to support more kickers that belongs vangogh series.

Looks good to me,  Reviewed-by: Madhav Chauhan <madhav.chauhan@amd.com>

Regards,
Madhav

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c          | 4 +++-
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c index 30ec826c8760..b7fc9ebdf1c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -941,6 +941,7 @@ static int nv_common_early_init(void *handle)
 		break;
 
 	case CHIP_VANGOGH:
+		adev->apu_flags |= AMD_APU_IS_VANGOGH;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_CGCG |
 			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_3D_CGCG |
@@ -951,7 +952,8 @@ static int nv_common_early_init(void *handle)
 			AMD_PG_SUPPORT_VCN |
 			AMD_PG_SUPPORT_VCN_DPG |
 			AMD_PG_SUPPORT_JPEG;
-		adev->external_rev_id = adev->rev_id + 0x01;
+		if (adev->apu_flags & AMD_APU_IS_VANGOGH)
+			adev->external_rev_id = adev->rev_id + 0x01;
 		break;
 	case CHIP_DIMGREY_CAVEFISH:
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG | diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 06c1aabf10ce..412602d84f71 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -46,6 +46,7 @@ enum amd_apu_flags {
 	AMD_APU_IS_PICASSO = 0x00000004UL,
 	AMD_APU_IS_RENOIR = 0x00000008UL,
 	AMD_APU_IS_GREEN_SARDINE = 0x00000010UL,
+	AMD_APU_IS_VANGOGH = 0x00000020UL,
 };
 
 /**
--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cmadhav.chauhan%40amd.com%7Cc43c7a79fe3040f68e8108d879adfbca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637393135477809168%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=%2FVT%2FERLWVVYFDruQu1hSfRjvcNDetIJkV81aMn3O8cE%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

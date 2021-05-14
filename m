Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D297FC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:46:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A00611CE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 07:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A00611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A26A6EE33;
	Fri, 14 May 2021 07:46:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4E36EE33
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:46:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcX7RPaC2pI5IzvqEc7iEeM9br03EjZ89nOmerBuev4jv43kaxVy/gew0NG14ctOPcwYC7KglQQ0EI+KQWMKkTU4Fc5Q2i7Sr+4QP0th3/64d8fkhCP7dteAUp7FBQQFPrF2t2crAzFohiugOA6djo35hoY//hdRSMTZn3uIr3CSOdbOqcVgTKZDmiUKs5T/KjE6qQQj/AoPQkme8awZA4pZZpQQ80vz9ObGJ5Vavbib1fFEhHesTH7GZQg3d0SIJKewOQct6dY9l11gooviAUJtWC8LrUx22qvl57XseKhEFe7dfk32lgMXMnwtfytKE6HQBtKUEW+JrwI/T3ukSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpFL4HKEHIkgIWZiRW6+KMCM62jZujFRTNWlfVdpplU=;
 b=iT1kTQAfsXOhS2Cg61HdFtGdcFTyIoYmwxGswoXUnZOhQtIhcJppQAEcTGjaZG5EsnDYH8DcUOKR/2PLF4KjAzPQuDWZhon2t3CfL1ssneYppQlPxpCa0qxQBjKCt7Y3XsAW8lVl5RRXqrirT+E5sGMjuw7zOJzdnW11+R8W1BT7kgJ9/Laz7vrXI+AjBEFaolVIBfj3DcqG/Ei4JORA+C6uKZQ11oLmW2UAAn/0xgcwlYiQ/RCTXZF2d3mmhd9MPlqdz02tcAdcJRQpvIUXdt9OLGaqEIJlBtf2F/nRlOJQxvNz9KXFHRXoEB/wdGLrNVuZg/KC14aRyqRf2kqbUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpFL4HKEHIkgIWZiRW6+KMCM62jZujFRTNWlfVdpplU=;
 b=IheqZOCwc+VF5eSY+6HG74O4hMFIrjfY09u3jIEu7GjG5U/47xZFYZHbd86bmXYdgQAIO/mw61CxBczgMLoLmwPBU183E+otkHU3xEJYR7MIoSaBRkgKklAFVd4403F+bB/fs+UVNSlcIH9dHqWgTL3KRSOzKN3DP64vevOcatw=
Received: from BN9PR12MB5226.namprd12.prod.outlook.com (2603:10b6:408:11f::11)
 by BN9PR12MB5292.namprd12.prod.outlook.com (2603:10b6:408:105::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24; Fri, 14 May
 2021 07:46:20 +0000
Received: from BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::24b2:3327:2142:b2f8]) by BN9PR12MB5226.namprd12.prod.outlook.com
 ([fe80::24b2:3327:2142:b2f8%3]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 07:46:20 +0000
From: "Clements, John" <John.Clements@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 6/6] drm/amdgpu: query boot config cap before issue psp cmd
Thread-Topic: [PATCH 6/6] drm/amdgpu: query boot config cap before issue psp
 cmd
Thread-Index: AQHXSJS8VQJXQf1stU+WZ8g2VHvs0arimSyQ
Date: Fri, 14 May 2021 07:46:20 +0000
Message-ID: <BN9PR12MB522601A5E41B2D4FFF1FE94FFB509@BN9PR12MB5226.namprd12.prod.outlook.com>
References: <1620978153-4564-1-git-send-email-Hawking.Zhang@amd.com>
 <1620978153-4564-6-git-send-email-Hawking.Zhang@amd.com>
In-Reply-To: <1620978153-4564-6-git-send-email-Hawking.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-14T07:46:14Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=dd799aa9-3724-498a-b037-fe3d5070cff4;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b596b9c-4fca-47fd-3033-08d916ac5d80
x-ms-traffictypediagnostic: BN9PR12MB5292:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB529222C6FA940A5294A93405FB509@BN9PR12MB5292.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yJ3p+Ol7kwHcjHSCNKn/erqJRt3UEbdOYAPGhoGpClATWIY9hUfiNSH2M8ct3CaoRcJMXLvQ93AKUkYv5tx1oW0M6+CHnaNk+8sGaAABmKSf1+ru2BIMrS8NIMvju/gcHDZHikMjGeSBf77WfsplIdbCU/InhU+LdMnwp8dhO7jE/L6Qpqzpt4v2DMrByGI/YeXWNPpEWU3OPgqhe+znWW/IL4BH6IFcpqma8DDIimw8QhlRIosmlVthaR3qGASXXABedT0JkSuxRw3chhk8YuhvG0I0Hsmiik5DEGNCsbPSPUcnTPjB/oqZEvuN6KWc9anfqbPdjm5po1qu7gsDIC4GAZV16ewBAfI/D6Yz20ZuoHITMXNTGyfvsvl7f67BAjraVEuEiJwZT3aCFMxQvC4BOu/rX+N6oGfBkOzXpKgQU1jUtEzM+8MohMQgfnyPr1P9NilVWvP5OT2YXz1Lsocx1K8auEiP6AjxUi3Hj9Q4vSbEStBJz7OkR5NjECGm4AN/terVrqgipIX8/duIm83+ElERpbC9h/+ZUK2lgj+fkQRGWK3W7wyo4M/Q0jiqRs7pRpDmnclrQgcRRCRKs997pNuOJmv1aiTwCDwNs7g=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5226.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(39860400002)(136003)(66946007)(8936002)(4326008)(2906002)(53546011)(110136005)(186003)(76116006)(38100700002)(52536014)(5660300002)(71200400001)(9686003)(6506007)(86362001)(55016002)(478600001)(26005)(8676002)(316002)(83380400001)(64756008)(7696005)(33656002)(66446008)(66556008)(66476007)(6636002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?vALnDz0ra81aedhMWUVw38fv4DUhJ2/TXcg7exbqbotPZ0EcKFdT+siCxk12?=
 =?us-ascii?Q?G0OLHWQC2+LiA/i+3rIK+CJDBXSPzfqmbW9sSVI4zTEu1zc8TDL45TdqZl5P?=
 =?us-ascii?Q?T5CGCB/NeStypy47RTVZEhWEQ+aWSR0VbS3CEJ1KxgPpPMW9dCdUT0T7mgRF?=
 =?us-ascii?Q?lJm2GRUKK3I9EbzHBXiICu4lPl9pFdLHRgKrb4YYHbVwNrGFnbWbItb2+0Fq?=
 =?us-ascii?Q?JskK4GiUF0zm4604N2pxLfWvomcj7x3p0YTw49vcOoH7ogXLGfJsEmyrA0YH?=
 =?us-ascii?Q?xmNfsJ0KTmIuccUhVDcQM9U02fQPcLEFbJ5k3E8tMrjOJQhzqk/lhi9x6Drt?=
 =?us-ascii?Q?e4xLI1qCpGOv3cxW25uaRNZLMa0LEMS0F07PbtUIPEvD72ajPviRWe+GaVcC?=
 =?us-ascii?Q?oF6j2Nx2oLk6sSWEfXuj8MQirdfwScqYYO4vKv9KZ4QvA7NZySl/yAXHpzgc?=
 =?us-ascii?Q?u2dMRuTreM4qrclhWr+yysEe4qg5Mx5Kcvapst/UIYKDqkKVe90bsTlgKFw5?=
 =?us-ascii?Q?+wMwc0lm52Izj+qI5UphEc5R3O/2wo+oC5KPrzGqwlrqqZrq9E2rCnULC4NE?=
 =?us-ascii?Q?6bueAVA5iyhP7fidrb1Pa1aPXFMpxvxwc8CsGnySza/9pXskZAvcEsgR7UOk?=
 =?us-ascii?Q?HZ8O4mNtrCb6NzXBYi53VTZVDdYyhCo4aeB/tLlUhAdFedzpt+LYKhMJ0Jba?=
 =?us-ascii?Q?1PPUT7eBFAufqQByu/Oj/Nc2vob1HyOC+jYszO++UErcTg09j18+fXIhGORB?=
 =?us-ascii?Q?nQuaJKGFgwbFnUoA4wXAN4lH2DrPKJiL+/pQ0l1qvBUBZGxYP/ehYV7z1NjY?=
 =?us-ascii?Q?DMCTTCL1ifAoo+SDdnGPBD+bS/09USK3qPJuu2y2vqYdEzAbkNPN0B6zuzdo?=
 =?us-ascii?Q?2f70Oyd0/hpou28bN5Mp3ya02a1Oh1NBuIs2hwP2AWCN5gYfuaqwlsuMCvw7?=
 =?us-ascii?Q?no3QNl6l+sZxRk53sNaCCSkVD7DMfkdtb7PcxeZwuSuiA2FpAsdbKuW6HoVj?=
 =?us-ascii?Q?Y/eEv0stIjoaWHhw0j95SPy5YJIP7JYxTV1JZPGLmzTW4kYPr90EwR98Qd8y?=
 =?us-ascii?Q?lQgKvEurSBqdXokA/X3wetL1rHzb9fR6TbCUtS096Ns8SdGvYvZZmI4p5r/q?=
 =?us-ascii?Q?CP84X/B8VoEG0u++Y9PDFOjM0cxVKlNaBJK7dKKQ8bMLZ/93n3OutXKZ7cMT?=
 =?us-ascii?Q?eRGjX/JBcbKSu+LoJW9LnKcCQG33kACECf+eFBSrYKQzMlQZ3nlKTTsUgBte?=
 =?us-ascii?Q?8BfvBs4+v1MZukmuIdtGBSTuyp++aTXJMckjxz0tZsgaQ43ONJc7zbw26dG0?=
 =?us-ascii?Q?S4kxIOGWWOqiEjC1qxRvERlh?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5226.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b596b9c-4fca-47fd-3033-08d916ac5d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 07:46:20.7020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iEhgdnKk+A4djfSE9do6ImnsIN9qlo3LDvL/oWUxmsv7jlCo1O2IeCOUWfBg1fUbzCWAEJWVrJ0snkadGO6ODg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5292
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
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is:
Reviewed-by: John Clements <john.clements@amd.com>

-----Original Message-----
From: Hawking Zhang <Hawking.Zhang@amd.com> 
Sent: Friday, May 14, 2021 3:43 PM
To: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH 6/6] drm/amdgpu: query boot config cap before issue psp cmd

Only send boot_config cmd to ASICs that support dynamic boot config. Otherwise, the boot_config cmd will fail.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f7bbb04..56a3c3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -38,6 +38,7 @@
 
 #include "amdgpu_ras.h"
 #include "amdgpu_securedisplay.h"
+#include "amdgpu_atomfirmware.h"
 
 static int psp_sysfs_init(struct amdgpu_device *adev);  static void psp_sysfs_fini(struct amdgpu_device *adev); @@ -538,7 +539,7 @@ static int psp_boot_config_set(struct amdgpu_device *adev)
 	struct psp_context *psp = &adev->psp;
 	struct psp_gfx_cmd_resp *cmd = psp->cmd;
 
-	if (adev->asic_type != CHIP_SIENNA_CICHLID || amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev))
 		return 0;
 
 	memset(cmd, 0, sizeof(struct psp_gfx_cmd_resp)); @@ -1931,9 +1932,10 @@ static int psp_hw_start(struct psp_context *psp)
 		return ret;
 	}
 
-	ret = psp_boot_config_set(adev);
-	if (ret) {
-		DRM_WARN("PSP set boot config@\n");
+	if (amdgpu_atomfirmware_dynamic_boot_config_supported(adev)) {
+		ret = psp_boot_config_set(adev);
+		if (ret)
+			dev_warn(adev->dev, "PSP set boot config failed\n");
 	}
 
 	ret = psp_tmr_init(psp);
--
2.7.4
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

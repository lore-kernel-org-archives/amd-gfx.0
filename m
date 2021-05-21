Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E28C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 03:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCDA76108D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 03:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDA76108D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 488F16E484;
	Fri, 21 May 2021 03:03:27 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16046E484
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 03:03:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnWifdTzdTYQO8aFX49+bTVg3MiwF+XpU1brsJteDfOLw4HHPiPGYG6UrGw8Ai7Go/CBZiSfULg2rBojyoNROjSl4hTdMIqvdadASfMDxtU4CLvLD/8PNA4obfrrEL0QiSIJDoQ84JBlWTxASw3Nv6OXzNdixPZm0YHKrkOYf3e9EfnoDhbVNyNEuZliTXahKdXnOlrkfahXUi5e64kS5JG+azYG/MrRcnPwLBDJy2bDE3EhOTPjfgjJlNyR8eP9G1XKK+z2f2PF0W4VPx8607kL2wWXkBwgHLTGc3KgGTy7FtygGivxy2Ywm3prq2pgk7VC/GXUA24+b4eqkLe8zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpmLQtNnjUp27quWdYlX25TuaRyCkwaoEksZXppI9JA=;
 b=VggAVSTCbtKEehkzweaSibSlGI2iFTcpzcePlHYk2/9heQlxSLIhO5bDi1jRLngXfAvzOTadORsCLfNPvGcayPXcZsZEHrl5hfoV7xsyYazONQ2cz6+91arwOiu0BdHY/yH1/4+70ZIvUlS7/ETVYdKUufXL0WfEc9NwdNkp+rcI4150ncfSyZ6W99OA261ZPRlQ6S22+Y1yLDMsQtMrgly81GaeCA2ccCAtZNIZdg2ydvnzvwcJwGYst4C+vbciF/9f+d65lo9PmvAwiWZxz/5KDVgSkP0SAid0A9TQkdM3Swl4q5RqYaLt0zLJ42bpGhK8Tkv4DQC4oTJocLq6PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpmLQtNnjUp27quWdYlX25TuaRyCkwaoEksZXppI9JA=;
 b=fX7L5v8S+0YmCOGyop7G6kRca+Eouw1dmrdydHFYvaFF7RAbacoGQS3yfuSfTJxSSTCpKJOKx3GeScDBhWfdJszW5+3jqVXZQmn4I2OpFFi8vO74apF+X978//MKZjNYFdNJIdr2NFaMoGGsduHDKw9CwLH193lOVozc7qDA6k4=
Received: from CY4PR12MB1287.namprd12.prod.outlook.com (2603:10b6:903:40::8)
 by CY4PR1201MB2550.namprd12.prod.outlook.com (2603:10b6:903:ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 21 May
 2021 03:03:21 +0000
Received: from CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835]) by CY4PR12MB1287.namprd12.prod.outlook.com
 ([fe80::50b1:6f8a:9b37:8835%4]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 03:03:21 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Gui, Jack" <Jack.Gui@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Correct reserved uint32_t number in
 beige_goby_PPTable
Thread-Topic: [PATCH] drm/amd/pm: Correct reserved uint32_t number in
 beige_goby_PPTable
Thread-Index: AQHXTe081pvcKLpsTkm50Q3BIpJa8KrtPxgQ
Date: Fri, 21 May 2021 03:03:20 +0000
Message-ID: <CY4PR12MB12873FBABBD06200A35BC26BF1299@CY4PR12MB1287.namprd12.prod.outlook.com>
References: <20210521025840.6203-1-Jack.Gui@amd.com>
In-Reply-To: <20210521025840.6203-1-Jack.Gui@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-21T03:03:18Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=9299512a-593f-4af8-8dad-ddd5c8518608;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0bfd5f4e-2c94-4e83-fe7f-08d91c04fdad
x-ms-traffictypediagnostic: CY4PR1201MB2550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB25508157A60DB79FF11E8413F1299@CY4PR1201MB2550.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CAlqnGAk4Z75qfRxaeJNul/KimRgdst9BFkRoFhsNgwSIwbpXeUbMYAPVaoqUUwmLEks1ddZ3+7GO51P6ku2OXoO6kr23g5gRNwpOUNSwQTLnlay5tDDkN0dXw+ssaBFeK6WODwsTMZd27TUaD4RLFp8DpQK1elc+xF3dWBLo7ltK35/iYJAWG1asqFNtNMS1wyWgV3ZRBdGveHgC11VNPr0PARmOURbZihV4kkn//S5LZ1/pbbHZQU7qXYftejaP6/z/boP/wYz7ro6pPqa38t/OT5L1JcQ5qk3t9EZN48nntI4umTIRLKgxtb4L06Pb7rePMogEQPkbO3Q7hsOd0c114CfgBQHGrdRqW4w9i593JilyTS71IXeQiTW/PX+7V5O/99Tvn6CF4SvG3fVTdeMyNDK7dUWx66D7MYuQy6tLIQf3CDEJhhMq2aVykSX6XfnuGd8yvHxOGFwayXxooXtm30k96UAgMSgf5w38r1W+aGrduFKCMWBMtmsMpk0jcxe57LXnVbOzNWg4HSJTMUYGCIvFa6P9lwivXT4sFD81f2pzKdphzIH6NcL2fA6HDeaI/opK+s65FiDElWA/RbyyZVN5HG/L/N5weyUfagYcK4Xrj3uGjh39B4ZH1jGy2qk9hMAXXu9S1JUzKfZ7A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1287.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(346002)(396003)(136003)(55016002)(110136005)(66446008)(64756008)(66556008)(316002)(54906003)(8936002)(66946007)(2906002)(966005)(5660300002)(478600001)(71200400001)(66476007)(45080400002)(8676002)(9686003)(186003)(76116006)(26005)(53546011)(38100700002)(7696005)(122000001)(6506007)(83380400001)(33656002)(86362001)(52536014)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gaW3U9JNMECN1tEa56ffS1zdI8xyarrvokNqG6kKxzLXk32LEdM7zoz3y+LE?=
 =?us-ascii?Q?kUkB0NS97Tw+a7eiQD8FcjScRePHc4mctdUtYwNgk37AzW/6+Zu35hIsjZJR?=
 =?us-ascii?Q?6+v/77v7A3NUM7+8DT7rBvYyvduhGi9qrcRuYQa9HxrO0zO/Y675R6vrOgjC?=
 =?us-ascii?Q?GmBern5w/01D7fAiyx53Ux46jRJDkMONxhuVNB85qukC2Qx8IVrZ7rFCIj0D?=
 =?us-ascii?Q?TX7mQi2/DpfSCxHo/JtK8B4ysWnZQGVBDooguzAg6iEtPvPZJso3ETadJq31?=
 =?us-ascii?Q?s66a63wgs8irgLMQiYm6/1hoFicFkodF+85JdDQSuQ2gwjWK6oqfC29KOjzj?=
 =?us-ascii?Q?ovN/tT9blq4ThYtSaAIlxR6vejgXlptBkhn4itPKdty0hTU846xbWufS5Tef?=
 =?us-ascii?Q?1mSycFLH96ZnhMLnay5vFgODQ+tQ/NYQFNfkDwK4INhZBuoyrSnKdY6W3YTw?=
 =?us-ascii?Q?ECLa5M70wlpp12cM0kEYwP4V/5XJO/6pPlUhFo9QNVfvMzGTIT70GgTYjap9?=
 =?us-ascii?Q?ivMXWbrrhqYpG0MDcEZoV8/UztCTYGvfQzoMGjozA/WYnsYcJx45L5BVOj5O?=
 =?us-ascii?Q?/bl7J//Z+Ydw0OVbMu2NDdm2YM+jZyM+5Zjz5SIsyOGS7NGUNvAEtNi0QJ1F?=
 =?us-ascii?Q?AQWwzJzzf/xJ49KPpBSnzK4cMrrkj0WT9qWL0vR5VFVnwW7WHvLP9lXqUaqH?=
 =?us-ascii?Q?bPOTDGj7Z0hKaRMEPoHQfZcJP/yt4pPPPnz1cNP4hToq1AiNavZyw4jlvDI3?=
 =?us-ascii?Q?lyIzkyKEZqoWaBwcG+DTf5ptFxl9h8zd0V0t8Q1xO5Ol8cRYmTwlpsFE08fP?=
 =?us-ascii?Q?jAeSKZ6ee1tc1ifyjGMAn86t1rcdrSBctyqj+zWscqEoVRmUPAcaCzdT+utA?=
 =?us-ascii?Q?cycZq5DPe/iQAXmxthYPsSdcpsypls3H1+kcHj/CxZDiDjfC2kzNXwooS68H?=
 =?us-ascii?Q?BtuJtuNibc6Juv6xS3lIvZ7wE6+9QX8OC0Di+qy0SenFUMnSbnJioSMU4Qu+?=
 =?us-ascii?Q?RHMqjwA+SxeZGuVZMeXq/UgbZkYV911GNIVXZhTeNwvJYalM7/WwX7KSPSIq?=
 =?us-ascii?Q?sOfjrCBb3iG3ca5MlL3Lb/nmHI9fAPjKTIGLZ7a715XTPvk11/QLiI6iYCXX?=
 =?us-ascii?Q?VMvX15ci2KPDSzmcOqHmQ5KH/8kmmpYztNvRo/PuZVTUT+VIKr77XlG0tOzT?=
 =?us-ascii?Q?3MAbzZhGJoWGmRc5ICmFfG49M4QG/CtXK5exwCcYh5Xy35FuGpAmvh9gDYlg?=
 =?us-ascii?Q?TaF7ahBCD8D95DLK7XO5S/EzDdX1qKjZe1HEHG9Vy1+oM2eGvYi3zC2TzZXi?=
 =?us-ascii?Q?/lPMNw6FRBtV1Htb2oIcEDGo?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1287.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfd5f4e-2c94-4e83-fe7f-08d91c04fdad
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 03:03:20.9302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nkZXX/+M3cKFeaC+fBWJzf5cWzWFOX51ZNf4a4Nmmh5JdUo9ERfgVooQ7U4rzVN/1kZKz5LAXeC0/6PDnoWktw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2550
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Gui,
 Jack" <Jack.Gui@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Guchun Chen <guchun.chen@amd.com>

I wonder shall we pay further attention to the alignment of the strucuture PPTable_beige_goby_t?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chengming Gui
Sent: Friday, May 21, 2021 10:59 AM
To: amd-gfx@lists.freedesktop.org
Cc: Feng, Kenneth <Kenneth.Feng@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Gui, Jack <Jack.Gui@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: Correct reserved uint32_t number in beige_goby_PPTable

Correct reserved number according to the latest struct in drm-next

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Change-Id: I5991a8ef53134c00348a96f776a539bad6da4fa1
---
 drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
index a1079256d318..61c87c39be80 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu11_driver_if_sienna_cichlid.h
@@ -1176,7 +1176,7 @@ typedef struct {
   uint16_t         LedGpio;            //GeneriA GPIO flag used to control the radeon LEDs
   uint16_t         GfxPowerStagesGpio; //Genlk_vsync GPIO flag used to control gfx power stages 
 
-  uint32_t         SkuReserved[55];
+  uint32_t         SkuReserved[63];
 
 
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cguchun.chen%40amd.com%7C563bcfec8f754835a9b508d91c045e0d%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637571627357436916%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=VbGji2Gx%2FDfl23ljJL1EBZJvJtquhjBtrgnolOxy1x8%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E1C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 10:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B9C60E0C
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 10:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B9C60E0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AD356E921;
	Mon, 17 May 2021 10:28:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5382F6E921
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 10:28:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cUbO+1VDnIwOB7WXZIcNRlP+XWZsO5O/A2/BwAtDb4fW0PRhsBtQ8N6AExC8/QzYDI1WwRCiQBVWTKDYN2mLf/AsvNtOz3T+H3A+mWTFS1EVx9fwJ3B/N+Ie7dnklMvR42IzGhj/RcjIWI1XROuDtB1Ttc9saj4H2iw+e//4g/YKD8t4tRWUHU8NTLqZaasS5jgQJWWfzbvBjDqblwvIwi0MbHcym0W1jXiLxUgAPZg0GiOLOWvpPIwLDKT+FyOjCzeAnieQUYcF+YbURZbvF1LfXFt5+l0V3s/9v3/Idz/KzvvTM2z6uHvuo9cw1HTS99dJi1ay8wuYFzrcrmYI5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF0SkXSWlldG0LVQIz7kvB+34FMB9Ozl0juI+ycfjHo=;
 b=Mi9QJHetlr25dbCmi7uN3QhOWkjjlkjoQGK2jVAgVqeLsH2sBShKv06DKMGB3ZJ0q4P19CMij2oJtV6EOtdwCEH4t+JG0DbYg/bowkT321aChTTYw1Cd54Tk25k46t3vvTGzYpiNL+m0L+lgZdd6V2dyEweOmPVtkZn4EpG8l5ROlcyxXL+sN7NIi/aSAT+fjIpSYmQdF/2tfyc00l6dRc1bI4OYt/mDa4rQ3r6F0RaL2Ll4dccwnK7voZk5hEpc/OOWoz0nxQAqcrSYLm0fPiNdTmn44jW7GFG5zG6ezflI93NIb4EzdyktMvTeP6dOuRX8vulhwyn1kffgg3w4pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JF0SkXSWlldG0LVQIz7kvB+34FMB9Ozl0juI+ycfjHo=;
 b=sTOWJgxtjAUclQC7OLxS6n0I76WniS58U633si67557/GymSWlzADlZmraWguxms2Db/6S+rM4b/Zq95aYjSyJNT9cqoSD4GwqG+zDASucxsOLGBl127LqJTiQPlymRoO+b65wRyC9Am1xyvKE2J3MCuK74Zt8PPJyLpMD4CR0Q=
Received: from CH0PR12MB5156.namprd12.prod.outlook.com (2603:10b6:610:bb::17)
 by CH0PR12MB5076.namprd12.prod.outlook.com (2603:10b6:610:e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Mon, 17 May
 2021 10:28:07 +0000
Received: from CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b]) by CH0PR12MB5156.namprd12.prod.outlook.com
 ([fe80::a1d1:38a:2086:b5b%3]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 10:28:07 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Nieto, David M" <David.Nieto@amd.com>,
 "maraeo@gmail.com" <maraeo@gmail.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add vbios version string
Thread-Topic: [PATCH] drm/amdgpu: Add vbios version string
Thread-Index: AQHXSwaBxKnElHi6p02JR9IfbD2zzqrnd0DA
Date: Mon, 17 May 2021 10:28:07 +0000
Message-ID: <CH0PR12MB51567775116DFAFB29E43821F82D9@CH0PR12MB5156.namprd12.prod.outlook.com>
References: <20210517102155.23753-1-Jiawei.Gu@amd.com>
In-Reply-To: <20210517102155.23753-1-Jiawei.Gu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-17T10:27:46Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=d0e543b9-5b28-4d64-b551-edd6ebedbcf0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ca15aa8-f9a7-4eb2-c7da-08d9191e7632
x-ms-traffictypediagnostic: CH0PR12MB5076:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB507664881CCAA33604DDD33AF82D9@CH0PR12MB5076.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/bn9yVQlLUkteyrVD7vlmNJFeHy8HZE7iHzKofCntJsbwhkz4ZN5wkYURoYuN89wh49y7c9McYsEEyADYlgZkmvk8X/NiBDWEN2L/wGG8ndSEk4Gtjuk1ZHp3LQMRh80+AzJKSPYPwZd5mIw6rGcl6agkASNb+uquPR0x5Wrx6aNn4AZ7kg4vVdKrvn0No4YFTb7d2qpnko8MPxqgnd8jmVn9FQ70XSnkJrjkBD3lp2Zosfl9bUvwOB2xqKr9r4tdvPcCa/cwHZQgbuQcXdn2oJGaLQmU7ddSyWis8Zew1ae7qiXh0Dit/ZvVSEmJGkUN0Q2MglzaYEn82myctKplGJsNh/0khf47717tLC2qHVipkmoKlBKTjB+lpp+tzX5dTB2exxg0isWJVGmbJB8Pd/yDw63wmGHdeXxSnnMBnIL/Ys1wOn6mTB/a5C52rtMnMOnxxMadnlBdzhvB4Uz5IUkzLGroFM9PNSN7C0de6LnahB7rS4DKHrze1SbuSLFjqvGnL/oaYtyGu5VXCZlQxzpSyBTqfiIEgQozWzHbe5qr/iVedNUKguRxmNxlyIiHl8Bpmd8t2KcBiYnRFztTovRe+hUfu3n3GxWu2ehaaccxqhz2c19S0bs17ix/mMjvFW8un3rZ4DWobjEYPi+sKULLsxof3g5Ag5aVI/nYc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5156.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(39860400002)(376002)(346002)(478600001)(2906002)(921005)(38100700002)(33656002)(86362001)(186003)(26005)(122000001)(6506007)(6636002)(5660300002)(83380400001)(4326008)(52536014)(110136005)(316002)(66946007)(66556008)(53546011)(71200400001)(66476007)(8676002)(8936002)(9686003)(55016002)(64756008)(66446008)(7696005)(76116006)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+WZYXfpbfcG1l8bkJPXF1hQ2AE5KYc3HZxFqnKC91BIBhz6gqp1nt6dhB34F?=
 =?us-ascii?Q?h8kq3A+PS+fobjUI1Bp4cu67Tx54jFY/VbhuYqpUHI1EsMiwPfeVakd/J8ur?=
 =?us-ascii?Q?PpczIU72vlGf75yTpIbhADZ4RJkH4Ub85+YyeSTEL0yS7LPJbnuzJunEF7EN?=
 =?us-ascii?Q?KAyDeEdWFu1n4wL2gA4tpI+h1g96wUcKEcRkgtypOcdBbJn7GJG9NI9QAJ7V?=
 =?us-ascii?Q?igyDhJHIwc7qQeCAL0F6ACxnKldxVUf96yRQoM3tzJa6YKDJk9hsZkX3ovHc?=
 =?us-ascii?Q?BhQr3wQObfEf8BaDI60SG51vqAitLfKENwv5Tz2HWDwP8upGbb0UCwEaZTv6?=
 =?us-ascii?Q?W7ZMU8H63TCHfpIazGLaHMN2Aq/0IjRAKDv8lc4tZYLu+PYx72AepgH+r2jI?=
 =?us-ascii?Q?N+rDMbeDUgwWih93FkLtD7kCf23JgJA+rQVwLBnV4xYtGdGBIeyKN5AbwTL9?=
 =?us-ascii?Q?ZbhZWmQi3n9ny7+diquPq3sV5YBVaiU81KH9XjK5lcsjCFOwKQKOpmJkD253?=
 =?us-ascii?Q?H+Vs72KA+OXstZB+MlYf70h3ZPmuAsiGVmjz+YYD8XqVjmKlNfIzulAlFBcS?=
 =?us-ascii?Q?9+iXGgIrqgQMqT2JHbuz4L5vBGOAtoaoPok1kFRmm7y6EbATqKfqH8eGo78d?=
 =?us-ascii?Q?jFkGWK6UZFiYFZUIdivYcq3xOSLlKXDiWlfTS4XkBUHHaiUSeDIZmT6NV1YB?=
 =?us-ascii?Q?fCPuq2Q3/yG2mVsfe51qA5O16FRN6OtboVWUEz3uotxQNJtiPpZqRxptDPTo?=
 =?us-ascii?Q?V7M/U1Spn10OV+q+r7gZuSbPvoqGNrZLJzkP3STzEK03w582wKPUOAwx1ZFO?=
 =?us-ascii?Q?VaWnE3zQ6XcS6eJFtc7MwshSr0uV+zXIsecytJ+370Ayu4BuxtEKhn6RAXPJ?=
 =?us-ascii?Q?ZHWLswrlwqcGfap3wIEDai47jAtj+ArN1Bv+87tQVoDcuCL0ux0iLTiaaaUh?=
 =?us-ascii?Q?+3C9ZU1atoI9U5rYfXLOWKvvvresQcSWcmJk0oJRUIxW6zrosHpAXVUEvBMl?=
 =?us-ascii?Q?VmeNDCQayzeVVLRSiqsn5nzTvZ4V75Z0ElAE30OtQslOeK7mxjSItb2WXzi1?=
 =?us-ascii?Q?Fixmw4PTyU+5/2xCuSuh1Uuyv/7hEzihb5Y546PYzPWXgfgoSyB4Dqe6Nczg?=
 =?us-ascii?Q?NbUFmUCFGMFIz4Jio6qL1Bu9CvihTf65Ln7UvIgL0gdOqGXfmQqblYSVDziQ?=
 =?us-ascii?Q?csPwxd/z7Sxvz0n9PEKwJ9qFM7WN3+ocxwEjjuYORXZ7XX+ngBWu1C1eoaTF?=
 =?us-ascii?Q?ruL4v7WcN9bomSTvHXkQPKe36dNqTXGlpBGWvMVjglei2QQc6nAkzmYRDKXy?=
 =?us-ascii?Q?8U1Dzc2ntTNfCX5DVktzaiMp?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5156.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ca15aa8-f9a7-4eb2-c7da-08d9191e7632
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2021 10:28:07.0964 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e61FkeSG/V/jUhuOTekH8uy1Gvd94x/MVfvQzfA8768mTHc8W2s3xhkv/Qid09BvS3oCcIm0+e3rJXWQ3LJPEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5076
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi all,

I know the vbios ioctl discussion is not settled down yet.
Please just regard this patch as a proposal to include vbios version string info into discussion.

Best regards,
Jiawei

-----Original Message-----
From: Jiawei Gu <Jiawei.Gu@amd.com> 
Sent: Monday, May 17, 2021 6:22 PM
To: amd-gfx@lists.freedesktop.org; Koenig, Christian <Christian.Koenig@amd.com>; Nieto, David M <David.Nieto@amd.com>; maraeo@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Subject: [PATCH] drm/amdgpu: Add vbios version string

Expose XXX.XXX.XXX.XXX.XXXXXX vbios version string in AMDGPU_INFO_VBIOS_INFO ioctl

Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  2 ++
 drivers/gpu/drm/amd/amdgpu/atom.c          | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/atom.h          |  1 +
 drivers/gpu/drm/amd/include/atomfirmware.h |  1 +
 include/uapi/drm/amdgpu_drm.h              |  1 +
 5 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e1008a79b441..30e4fed3de22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -870,6 +870,8 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			vbios_info.dbdf = PCI_DEVID(adev->pdev->bus->number, adev->pdev->devfn);
 			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
 			vbios_info.version = atom_context->version;
+			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
+						sizeof(atom_context->vbios_ver_str));
 			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
 			vbios_info.serial = adev->unique_id;
 			vbios_info.dev_id = adev->pdev->device; diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 0e2f0ea13b40..542b2c2414e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1438,6 +1438,21 @@ static void atom_get_vbios_pn(struct atom_context *ctx)
 	}
 }
 
+static void atom_get_vbios_version(struct atom_context *ctx) {
+	unsigned char *vbios_ver;
+
+	/* find anchor ATOMBIOSBK-AMD */
+	vbios_ver = atom_find_str_in_rom(ctx, BIOS_VERSION_PREFIX, 3, 1024, 64);
+	if (vbios_ver != NULL) {
+		/* skip ATOMBIOSBK-AMD VER */
+		vbios_ver += 18;
+		memcpy(ctx->vbios_ver_str, vbios_ver, STRLEN_NORMAL);
+	} else {
+		ctx->vbios_ver_str[0] = '\0';
+	}
+}
+
 struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)  {
 	int base;
@@ -1511,6 +1526,7 @@ struct atom_context *amdgpu_atom_parse(struct card_info *card, void *bios)
 	atom_get_vbios_name(ctx);
 	atom_get_vbios_pn(ctx);
 	atom_get_vbios_date(ctx);
+	atom_get_vbios_version(ctx);
 
 	return ctx;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.h b/drivers/gpu/drm/amd/amdgpu/atom.h
index c729f7ceba4f..6463ce6e756d 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.h
+++ b/drivers/gpu/drm/amd/amdgpu/atom.h
@@ -148,6 +148,7 @@ struct atom_context {
 	uint8_t name[STRLEN_LONG];
 	uint8_t vbios_pn[STRLEN_LONG];
 	uint32_t version;
+	uint8_t vbios_ver_str[STRLEN_NORMAL];
 	uint8_t date[STRLEN_NORMAL];
 	uint32_t sub_dev_id;
 	uint32_t sub_ved_id;
diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
index 14d0d7d58255..28deecc2f990 100644
--- a/drivers/gpu/drm/amd/include/atomfirmware.h
+++ b/drivers/gpu/drm/amd/include/atomfirmware.h
@@ -198,6 +198,7 @@ enum atom_dp_vs_preemph_def{  };
 
 #define BIOS_ATOM_PREFIX   "ATOMBIOS"
+#define BIOS_VERSION_PREFIX  "ATOMBIOSBK-AMD"
 #define BIOS_STRING_LENGTH 43
 
 /*
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h index 2d9e84658bbc..e0f98ca9a755 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -956,6 +956,7 @@ struct drm_amdgpu_info_vbios {
 	__u32 dbdf;
 	__u8 vbios_pn[64];
 	__u32 version;
+	__u8 vbios_ver_str[32];
 	__u8 date[32];
 	__u64 serial;
 	__u32 dev_id;
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

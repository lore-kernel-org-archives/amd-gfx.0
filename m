Return-Path: <SRS0=hzAD=H7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050A7C433DB
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:31:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EF1764E22
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Mar 2021 09:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EF1764E22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C84C6E54C;
	Mon,  1 Mar 2021 09:31:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D786E558
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Mar 2021 09:31:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA78bHAslX48m1y4n2sSMLJ1vLaw/ncal+YbImMB0SLeoggqrxdfgFtMD/TeC+xHyNKTyWQ7fQzB198UTveWwuEuojX/uWMwtz7qV6Fb6HmmQ5fyf/GIN3Gi7OirKJJHkbgbhRG3hkx5AT9P6ha99SJYtU1xHQRYvqX//y35NGg1nyH2/gz2yZyshgoYDjSiNXz/HzmXqpl5o7MFJNFjDtvVUHICPR2390JdK9OjpOu8ebEfMNMpIXWYrISBzmlvUhbwmaD/jEvrlIX3FojvCHvo/W5dX7EuSNlhBcCrWjj29nWnxPdIa2DfplhVnPg9xVYSr0xYoqYRZmbgozLS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvw0T4TW6nHkfEPjM7ixJDx0d8dbpmxo84G2gMrGoVE=;
 b=cF7+Tim8eZNdrbArRNGSHuZscC30lfRe4UNY1EJgx2rE9n55NsGYMSo5C1ie5XQ9246V8GDCRJoiCmL85HvQT8tm/NLgHjcOf+m9uhsyJbbLZkp8KLtxEYvP9SrQVy4VJxmrEMtAbwXXncSFhfSdSccnzFjahGoh60L+/2y4SS3FVHB3Tpt5drtZz8UQpMDazBRpn6KiJZa2doPOWWN8RNXCeSK1IMHD3/lol2qI7WhHCAlhp+P7N2FEQhw2g2J7eZkEjPG60s7nseeJRcjriq3eIm7pFElv5Yo030W0IBeOGGbeSCTvBWx8S4rR9qvKM6QDPWey6P0NSlzP7qvpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xvw0T4TW6nHkfEPjM7ixJDx0d8dbpmxo84G2gMrGoVE=;
 b=C/Uv6nMbPPMqmqnR40R1uHnZD3NAqPTD2PDdwcx87bX+F/ZYcjs+d5A+0ZVvXxI0JFk+F0ftLhIANRlcvBG5MHnIs+L6EkeXcmQX8IbOLLRT8KOOk4yeiUoTSzMjBZJiAF1RO3aHc2IZ4sHtYes8L3DwaGMJQVjgqNn/CaDs6n0=
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.23; Mon, 1 Mar 2021 09:31:49 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::34e3:c46e:188c:ef53%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 09:31:49 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: add SECURE DISPLAY TA firmware info in
 debugfs
Thread-Topic: [PATCH 2/2] drm/amdgpu: add SECURE DISPLAY TA firmware info in
 debugfs
Thread-Index: AQHXDnqrPEfehKwYekiEiX+AxHlqNKpu3kXQ
Date: Mon, 1 Mar 2021 09:31:49 +0000
Message-ID: <DM6PR12MB4075210D39089C80AE30EDA7FC9A9@DM6PR12MB4075.namprd12.prod.outlook.com>
References: <20210301090951.43956-1-kevin1.wang@amd.com>
 <20210301090951.43956-2-kevin1.wang@amd.com>
In-Reply-To: <20210301090951.43956-2-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-01T09:31:47Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a25edfdf-0ef3-4413-8bd5-ea524c4014ba;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7c2cead-b9de-4367-f966-08d8dc94d6ed
x-ms-traffictypediagnostic: DM6PR12MB3177:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3177415EA0F59FDAC80B34E6FC9A9@DM6PR12MB3177.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h2TW2WuGMCg/xGTBzdrgQGhDFAfq19iH381DI4ZyCkQiPvXelaOwHANFNHHj5WLOcivFvNfNEvHsGCIbvO/yIvy0fO5Mr0NiRD33cp4IwY4pVcD7/8KfUoNNNW7WgWh4576cJLYahrVZfkMklWItY51F0siEXw2Urq3YxqMHf4JgvKwDJqkmcMLPOeX+H1SmRbGmLSvqnODnhsWi8cSg2IFcNWLmyux5NmuYB3f6P6seseUMP5JeKqTrPWf2OUEPId98e1ym4SywwMJ/jxAB4duIm2YWOpCPIoAhjHk2nJ2TXhhG1BJcJmY1JN2HaLIxXXzpRa/FlW+YjJWUd36DS3uBZivqGzafvQibLf7IrKtiFrAPgySaFAPAzXq60rlC74AjWa54xAxFPBIkCilb/3QN+3SuDYQeA6+Qtka87R1MH21LQ8UrP1QFVk3fMvoRdXHMB6vQsKUYu3ucr5BkYNYiD+SYDFQLOEXxIONwfNTWcp843Y6XY9oXk1INEaH/msVBvnMaDU4LCSHZDAcGiA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(110136005)(83380400001)(478600001)(316002)(7696005)(6506007)(53546011)(66946007)(66446008)(64756008)(66476007)(66556008)(86362001)(76116006)(9686003)(33656002)(8676002)(5660300002)(71200400001)(186003)(26005)(8936002)(2906002)(55016002)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?e/D/j0FegOlLg/+huAOqDPIbM9V3GhzLWHMiMjSVYQx9gFK4YM/JkoooFwxX?=
 =?us-ascii?Q?wNRYxhuZR738wUCTuErn7WxVaWT9jf/ROAzq+DPaf5/tvjgfFiUJAcThd5g/?=
 =?us-ascii?Q?UM3VreweWk17t/S3hqRyq9gk0WL1TKhKQFTmIXLwe/YVwEUW6WZG1xL0KQI6?=
 =?us-ascii?Q?yyOcXKrkfHHuVb2zd560fm9AtNjJVcVxEJa4Y/L0SHlN2fbLJ6zqdgBE9sEL?=
 =?us-ascii?Q?m+lShd0kGZifOnjBWrm8gag0Dav0qx1s1BpvoKU8jH0no1uv5KTZgMc91xiv?=
 =?us-ascii?Q?XBYBXBXZ/pSusxm8U3ucTYgJebAYp7xYr69Te/QhECdMFeHlLOEf478rihp4?=
 =?us-ascii?Q?xyii864pKFTCrtC6lMFjicmBzRMvlY9yLT3nekGDSpcE4ooJtLkGoKcKEIB0?=
 =?us-ascii?Q?Tyl+U069GfGkub2T1gIePnw8eFFWcsxUsO3xbNwGjGijK8qkFcu5gyj5R7il?=
 =?us-ascii?Q?rJWiN8kULC+k2pqXG4gVu4fnQ4X2Lken2WEVsHBDcjIYpkjyZOFC/QHA22Pn?=
 =?us-ascii?Q?5b9fZKVCgB3Q+QUv2KAsM7f2OnGGqmVercEXfKZO8DoGdf7pmwEatpJCJ4FY?=
 =?us-ascii?Q?EBrnjfnJLl/75NfYXOHHe+PVYKJtEPu8AyKEAPFQbOypmtN2l5fWBjy23aDP?=
 =?us-ascii?Q?NRyzhdC8M/JgD7c1ehMvobAUTpjkD32TKcsLufBUKjGKLYoOZO1eAnEU49Lz?=
 =?us-ascii?Q?xD2+Yp4e7gWkw/HJqMQlZ2zCuI8zz6coAbgranFirhEYgeex4+ZcOhCiGr36?=
 =?us-ascii?Q?HTsDoPB/B5LwZzcdBeNQ+rXDSrnVzfQ84I7UTM0s5BV0F5Zyp7bOGgN8x7ZT?=
 =?us-ascii?Q?SQ+OjYJoO4i9f5jLYD1nXTTUbmxUHiMyD2asGrv7JI5w/2GAW9/NxG9uayAd?=
 =?us-ascii?Q?oBVicxwEseKaeO65YuGbLOm9YJphGdDmmxGZR8RJKW+wTEaWYR+O9oSdHIQC?=
 =?us-ascii?Q?kHYLXD6fxb22Is1/LbWVfeyJZfaiRYIo87MhJaICOqKJFFcyqyRlyUdkzP7q?=
 =?us-ascii?Q?iQ2TJl1lLDJbL7mNcsgQzJZcq7Qwr4sOSRRyRVbNtJuW+/5P+zgsmkvT65tf?=
 =?us-ascii?Q?BitxDUy8UcIxnN+sXOpVF6NIrBfj5SLCKbxHpHDjRpjQ92TjYj4ySAGB7hwR?=
 =?us-ascii?Q?SDzGpl85wPQL9C6X2VctzU/5xlXo7mLqEn7ayV4Z0I3ZLyQ1GvFbLhwyAZfm?=
 =?us-ascii?Q?l+h54M7JcNbRcyY7dmBhIM7+m5KCtaokNOblxHt9458pNmobaDMBUXDdXOY1?=
 =?us-ascii?Q?Qhe+8TqWfj7J9YbOGLW7ARdrMTbxHqe731I32xBOGSgh7tb8BSzykVaOTfTw?=
 =?us-ascii?Q?C+O7p6dvn5rxGBoh2Avm2ejf?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c2cead-b9de-4367-f966-08d8dc94d6ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 09:31:49.1269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QDfFSutkRbkZo2cA5pm/15i0YUJ5qSVuAtZMbwdKNdQXJT+UZbpgb0ges6AlGC4vThskYlIsfvMsCQVhBFgPMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

With my concern on patch #1 addressed, the series is

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Wang, Kevin(Yang) <Kevin1.Wang@amd.com> 
Sent: Monday, March 1, 2021 17:10
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add SECURE DISPLAY TA firmware info in debugfs

add SECUREDISPLAY TA firmware info in amdgpu_fimrware_info()

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1a27673271b0..ed51dd0468e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -309,6 +309,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_rap_ucode_version;
 			break;
+		case TA_FW_TYPE_PSP_SECUREDISPLAY:
+			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->feature = adev->psp.ta_securedisplay_ucode_version;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1363,6 +1367,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 		TA_FW_NAME(HDCP),
 		TA_FW_NAME(DTM),
 		TA_FW_NAME(RAP),
+		TA_FW_NAME(SECUREDISPLAY),
 #undef TA_FW_NAME
 	};
 
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

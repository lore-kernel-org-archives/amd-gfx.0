Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD1DC35640
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 07:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D2942073A
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 07:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uvYh7Wi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2942073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAF936EEA5;
	Fri, 21 Feb 2020 07:08:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D0F6EEA5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 07:08:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5ulGOWDZ67XQ0fpSaCn2hkRvvrNtMht5r5BsO/aRt0oYeFaXlVNhuLPQcxJ4dzab9ZVk15SlJghk73Qg3FEeAb9AkLhvcs1HJxsvS6dw34766MG1XW6lOYbR0vOTFuRTXa8k5R0sDqFfiIf1o41uN1TBIUG4gLFdPQeDk50GjAJTRumKLtJJBz2HmWmad4OSKAyg9sCkYpzzjEJvLzw7IzayES6PMNpAvYla8+y2LF0F3gxsLBNI/ZKedC8MHMbnSARkDv5sauuieUJlmTfFiJa+4JZObdpsfmD+tIgMNbWRaH0c38V5VH7LnHBZbAhtIIgqeLOpq8/60lAMPTa0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5ePWjGrGIokrO/OhHYmARYV1V1NwJFhVhCZUJmnN3A=;
 b=hIeJkX6COBFFl8PYqPV20BH6DnsjB1ZHdF78tU7JEJ+QsFlPK/N8JbZ6T2XmyZvDz912mAV7XYrai8N+eZeXXVEzOwWioWS8Kajhexp8tDg7uGWlXVdJtJUkCwWa8TT4kauci+nxEiuFkwhYPJhMp9GRZH3idfvQ30BEtKD0gaE8HT6DHFNVU9lfFr3wZvWtazutNDK9XS/9Wsu15EhT7hLmrIh9UDugfgGdeK5R5da17oKmM99oiVp7jnPypyoi+c7Sw+aU4ACiUT8Wgp9xyoA57e0E6BLtxUc9eCXBfmyCJRENUZsT0qYPfiDuIyxO+63MZOQV4BttUICL3aWu0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5ePWjGrGIokrO/OhHYmARYV1V1NwJFhVhCZUJmnN3A=;
 b=uvYh7Wi1rwPymeT7LJDtKhCkN2cLIX0Kw9R3Y29c96Fw9pYIhdRIb4nSON8193KWwWMdYwWrplR5j5SGWJFGZCasiRG0RTz2QhsgKvOglQoHhooEp2bgeQd9qUjhgSCcpZ37z9+pemiPbZg8l1ofz9lXsvCPE5L8VWjm3u5oT58=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (2603:10b6:208:c5::10)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Fri, 21 Feb
 2020 07:08:12 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 07:08:12 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Liu, Monk" <Monk.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: fix psp ucode not loaded in bare-metal
Thread-Topic: [PATCH] drm/amdgpu: fix psp ucode not loaded in bare-metal
Thread-Index: AQHV6IPs0UTBfHB8wkKbsqg0Q3EEtqglOjeQ
Date: Fri, 21 Feb 2020 07:08:11 +0000
Message-ID: <MN2PR12MB334478B360F6EE358DBE000FE4120@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <1582268124-31292-1-git-send-email-Monk.Liu@amd.com>
In-Reply-To: <1582268124-31292-1-git-send-email-Monk.Liu@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=e3cbd3df-d1fb-4b20-983a-0000eaff75e0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-21T07:07:49Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9643ce81-c469-4e1a-a8ef-08d7b69cd049
x-ms-traffictypediagnostic: MN2PR12MB4208:|MN2PR12MB4208:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB420860D02DD8F42EF8629D6EE4120@MN2PR12MB4208.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(199004)(189003)(33656002)(86362001)(9686003)(2906002)(81166006)(7696005)(55016002)(81156014)(8676002)(52536014)(4326008)(8936002)(6506007)(66476007)(26005)(186003)(966005)(71200400001)(110136005)(53546011)(478600001)(66556008)(66946007)(316002)(66446008)(5660300002)(76116006)(64756008)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4208;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XxyfYu/BdDGjbZd0SKSQnRTQgD7OB6OHJmcI3Y5XGmYBOr7/WusyqGWXAzhlQJUFsGXuAcwnxTujWSADfo8i7SCtJe+z4KcEoH2vPocOsFhRvDkBDcrAebSLD73PLa+kQBrr9/TZNn1oE+2M9tCRAAcvF+3theDPyhGK3RXItdrN5z4YLhNAIg4LQXAinwhVVLoAsqcA3Ty959xs79Qab6MA71N58TPdjkZGTLRb7WXdt+G8I3klVUNfqx3NcSxqGdmOtElS26TIZ63AmNyEf+pDiv1noy1ZtoCyU1WrFLgrkjM7IdHV9rh5fb7g4oWU93/Bzzxf7EABNkqLLIVNhKF2M4nvxebyGok1ZJ3JIGtuStq8TnhJ1nLq+oR/QvSYV83cdDUW2FB+Y2bPqjY0ld16unzdQrX3ZBoxuavREGe1X8xXtjwqPAoKBodydmceCnxuh/vhs+jSBO+RBYr2oXCaV/gkI6x/0qIxAn+vQwIYkAXs4jo/SnXm8GQNvevx
x-ms-exchange-antispam-messagedata: j2XynPdWYJ611gOBMVMrM6ljP0ewB1kPWP4a9pEPCX2dhtlaFekCA/VuQ5dl2WB9r8wVAebM5sEgBEj0ZBwmlyMR0KRVUmowECbJXXjCb80eAz/sW13mYQabqWY8zd9Y/zShnqHBaKZ0e2L9VnF4ig==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9643ce81-c469-4e1a-a8ef-08d7b69cd049
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 07:08:11.9837 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YXmNXSnfgKTF9/gFehZ8sc8j2O7SIulNfNGK6mArNO0fHpvtxn7Mn03EkgVPO9MU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
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
Cc: "Liu, Monk" <Monk.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Monk Liu
Sent: Friday, February 21, 2020 2:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Monk <Monk.Liu@amd.com>
Subject: [PATCH] drm/amdgpu: fix psp ucode not loaded in bare-metal

for bare-metal we alawys need to load sys/sos/kdb

Signed-off-by: Monk Liu <Monk.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3494966..51839ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1081,7 +1081,7 @@ static int psp_hw_start(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 	int ret;
 
-	if (!amdgpu_sriov_vf(adev) && !adev->in_gpu_reset) {
+	if (!amdgpu_sriov_vf(adev)) {
 		if (psp->kdb_bin_size &&
 		    (psp->funcs->bootloader_load_kdb != NULL)) {
 			ret = psp_bootloader_load_kdb(psp);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7Ca9fa0bd3af1f4895665308d7b69b0bed%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637178649379281707&amp;sdata=lPjDrsKmIeuU%2FnM5NwCyYSIvSzTIRHR%2Fer3cri6I4vI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

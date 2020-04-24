Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4BEC2BA19
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 02:47:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9150C2075A
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 02:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3/a+lx0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9150C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 289126E426;
	Fri, 24 Apr 2020 02:47:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0777B6E426
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 02:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Or3MTBKvCSGOcHtRcb75nzO5U1mqsPG16TJiuY5x4lW/4G/ZMD0vGmEvtj0rdOlPqIj8ug7w2P3k6z/OfPR+Ghx7iTF4IleqioUNwp4DNB3PceIn95rae2yo0mwfbrKLubdI5OkDTk4Q8xutcIXRpF3bVJJ4yMP+BvJj8whAwr3zgGbmre7U4RfqtzHyOsezbnN2xH1JUNBAZ/I9dR3h3zapgz/ouQf9qUpJRf9SyUHjQFnWD8GFpRxZFtHab1t4+xoE9Re1WcM1ghSzKIRh3D740rSGAnfsp7+PwQSpt4StbMFctQDn1PsIUd1T5E5QswHHUuP9TCHo4KIu2PNyKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1XVS/Ss+0BO1M2rVGAsFzPMnepGbRoGKqYIlKhxW/g=;
 b=f6T4M0Xo2t1NGx5dfPFQl2uGKsVN9+UB9P3zWspsCxXykhY2bos7ZMp3FbAsvt/9If/5wZIvgO+y5f2p6dU5UQwTnU5RtLGsWR30bzBDkeJQvgMXGkuofw1DO+6tyRBs9aXbxJsz513Sw6g0mjgD963vfLgB5PIebretyNG5qBz1SefIanBC6q9cxMcTg+8SC3tt8NWS3v/htN0983GH3KecNUQBH0YKezJKQeAz1f+SI9L0EXfzU0cSBvGb+a/wzjdW2a27ctVU44izvZtEIRQINWQtqK2J9OIr9WbiLw1xwT4XmQRvakH8OYZaVAkigQuDDsNnjwkwIwDM5nCbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1XVS/Ss+0BO1M2rVGAsFzPMnepGbRoGKqYIlKhxW/g=;
 b=3/a+lx0lQO8I206Ux8shGf+webhRBjz6cHYrDQBSmgjVqp4M72OPQBDA54Mm4DuSTzDo9k86yiBMTV81RHidB0CSzZdsvJX72vMjp4efdF2/uYaSg7c16/6pKuuuspPmnL7rUP79kK9pUDZOS9wNIywuAXAL1JeUJuwgotqLkuI=
Received: from MWHPR1201MB0032.namprd12.prod.outlook.com
 (2603:10b6:301:4f::10) by MWHPR1201MB0143.namprd12.prod.outlook.com
 (2603:10b6:301:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 02:47:38 +0000
Received: from MWHPR1201MB0032.namprd12.prod.outlook.com
 ([fe80::cc8a:d458:39c6:a3bc]) by MWHPR1201MB0032.namprd12.prod.outlook.com
 ([fe80::cc8a:d458:39c6:a3bc%12]) with mapi id 15.20.2937.012; Fri, 24 Apr
 2020 02:47:38 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: check ring type for secure IBs
Thread-Topic: [PATCH] drm/amdgpu: check ring type for secure IBs
Thread-Index: AQHWGbCY7wZooFid8ky6lSXCp4l0naiHkdTA
Date: Fri, 24 Apr 2020 02:47:38 +0000
Message-ID: <MWHPR1201MB00323F3EDB890BE1F4C26E47F0D00@MWHPR1201MB0032.namprd12.prod.outlook.com>
References: <20200423204720.1063581-1-alexander.deucher@amd.com>
In-Reply-To: <20200423204720.1063581-1-alexander.deucher@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-24T02:47:34Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=13f04bb2-5c96-4d93-9681-00009cbe2d8d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-24T02:47:34Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: a6d77936-3692-4744-9316-0000dde33a44
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Aaron.Liu@amd.com; 
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 844d0d44-f365-4f26-dbd2-08d7e7f9d9d9
x-ms-traffictypediagnostic: MWHPR1201MB0143:|MWHPR1201MB0143:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB0143CFD68367F814C9200DB0F0D00@MWHPR1201MB0143.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 03838E948C
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0032.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(478600001)(45080400002)(4326008)(966005)(71200400001)(5660300002)(2906002)(33656002)(53546011)(110136005)(81156014)(26005)(6506007)(52536014)(76116006)(186003)(66476007)(66446008)(7696005)(316002)(86362001)(66556008)(64756008)(8676002)(55016002)(8936002)(9686003)(66946007);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xT2lK1UPa5kI1ui6RT9T/ea/+RUnup+TpkRrfC53fDOoxIvQqWOCvw+yUAk0eN0zfhII2S9w8HkM1YSZB8OU3avV0CBnQquxkcI/9GnbXfgQXzwpQlkmc8173MWRx+cBy7ScuRHppU9495zAGj7VvrYgSyALGTcaPfDiHFEsU79CIfl49j4xx5LgbwslifwCOZPmvNg6v8VGS80EPGWULviSZc1xetDWJK/lj1y2Rjx2qvVpLaL7p2HEY7N2GNM+LvUpSbXJSIg4KGxlXQ23Z1pcHYV0G2f7ce5Qi2YeTq3QrNMv00PK6pTMMzGePIbhEk8hpXcpLoJhi1S/dWkJp1IbMz2/m1vnGzogM/GLWZ43JLcnZd0vC3qVb6t8wKe7JjM5ATPd8rCNcHycX4vSENErLPKMN/a1/4X+Qou8Qn4ZkexmGmhbF0GDzSrPhZsZFAkhG+/b9CSLRU0oD7/AF+bXJ4c/o2Ruw8u/FAO36W0=
x-ms-exchange-antispam-messagedata: JhcxuiPalEZsJcohOK1iyni9CU55JLopB3HN8Lk0LYGJ0p0awkTCrdA0IcEpZBChahJkm82SzxkGdz88P+U9z05DW9E1VLXU7Kb8HB2LFbOtM6s11EygNefYPkxNL3VY/UQFUQtUwg1CyAHYBjRZkw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844d0d44-f365-4f26-dbd2-08d7e7f9d9d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2020 02:47:38.2571 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ae2qGHey52U9ubhHXtTjsAop+Rduf/0+Doa97V5AW3JzdYLltQl5gXsEhUftv1av
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0143
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Aaron Liu <aaron.liu@amd.com>

--
Best Regards
Aaron Liu

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Friday, April 24, 2020 4:47 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: check ring type for secure IBs

We don't support secure operation on compute rings at the moment so reject them.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index ec2c5e164cd3..b91853fd66d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -161,6 +161,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		return -EINVAL;
 	}
 
+	if ((ib->flags & AMDGPU_IB_FLAGS_SECURE) &&
+	    (ring->funcs->type == AMDGPU_RING_TYPE_COMPUTE)) {
+		dev_err(adev->dev, "secure submissions not supported on compute rings\n");
+		return -EINVAL;
+	}
+
 	alloc_size = ring->funcs->emit_frame_size + num_ibs *
 		ring->funcs->emit_ib_size;
 
--
2.25.3

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Caaron.liu%40amd.com%7C4237b46dff1743425aa708d7e7c78c83%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637232717308400132&amp;sdata=0%2BSeNlm5n2%2F3OaMf%2Bw0ArpVcyenjJ2fO%2FwaRymsbZxI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

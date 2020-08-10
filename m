Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C29FC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7462065C
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 05:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="iYVRqL3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7462065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E26556E119;
	Mon, 10 Aug 2020 05:26:17 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA5F06E119
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 05:26:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbLeyJis4rUEGZYlHw92yFP10Nr+L8oH4TVNzkTfvSVS41VOyutvcl4YzbcfzuBEV+N7vMdmM91o3w/gAN0F8sIa5wnpVPaT6P2S/qZsWEDVtKGWx4pVrC6jcOsIdWKDSjK7we8xCF+a084W55oLwE1d9clJzWi9G6JSrXmuBdFHdlDUiVEBwhlMZNDGaoMXtWatOds7xOKziNKZIpR5Pif5vPPnnYktUl+J5q145i04dv9Itx7/MbTWgHHs6nFKkQ72bF6+bIQSr/R1qEYOnj7wr6yn79ehfhkS642dFr65AMOaZ3yzlauthrQcI47y/uwXRjJ2eNp8xsPmt66yxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVHyaCgSv9PxdHG7H4gl0aDwxpVCv1ZeIlGr5cM/ddY=;
 b=K3ELk3gr5g6SkSpPzGgobW2GR8Zg+nF5GKJFYHxEb4k16lyQovxu2IOcUi0324XBLtItNoCpk11mfZo77qJdKYGj8s1ivZGhleLB9/39pTFBrbNGGyFiXRH9D/zqUTGAzFBff3p+bcRSU4nh9z53y1JcKQ2RyqLpcD7qrxj9KZBzyaLN2NpFFbmQIlUNlv2fxJ0ZKt3wrYYFKisorqGBuHedbPjMPzVLPVIwQECwQ3YspIBgc+wWrepKe2zfrYZw6Bk6dGx3nDX8SH2ruOPheKbxG1UvKCaXczA4NTIC6QVulCvHHranPQjfIRLmEYBdloqcYLHqr5lhs/q9zIrq9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVHyaCgSv9PxdHG7H4gl0aDwxpVCv1ZeIlGr5cM/ddY=;
 b=iYVRqL3dqmqDWGiHEYOU8X3J2kHd6yvFyBDwUOYrINkTbRdGpqBDmXUUN1+O03RCJdaYZLFUNaJW1z9EkchJI8XrYTGxtIffaxna8rozuo3ZlB6LQ7FBsgXQh7/hqkqXyFi7DW7wREH3895VfMHTA7I0JKutcF8L4sShNXzRY4g=
Received: from DM5PR12MB2533.namprd12.prod.outlook.com (2603:10b6:4:b0::10) by
 DM6PR12MB3482.namprd12.prod.outlook.com (2603:10b6:5:3d::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Mon, 10 Aug 2020 05:26:10 +0000
Received: from DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63]) by DM5PR12MB2533.namprd12.prod.outlook.com
 ([fe80::b184:d0e4:c548:df63%7]) with mapi id 15.20.3261.022; Mon, 10 Aug 2020
 05:26:10 +0000
From: "Li, Dennis" <Dennis.Li@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "Clements, John" <John.Clements@amd.com>
Subject: RE: [PATCH 2/2] drm/amdgpu: add debugfs node to toggle ras error cnt
 harvest
Thread-Topic: [PATCH 2/2] drm/amdgpu: add debugfs node to toggle ras error cnt
 harvest
Thread-Index: AQHWbtZvWMxLgqzX706PkK5LoNkG/6kwz43g
Date: Mon, 10 Aug 2020 05:26:10 +0000
Message-ID: <DM5PR12MB2533FC270361FAFDF817C582ED440@DM5PR12MB2533.namprd12.prod.outlook.com>
References: <20200810052258.27961-1-guchun.chen@amd.com>
 <20200810052258.27961-2-guchun.chen@amd.com>
In-Reply-To: <20200810052258.27961-2-guchun.chen@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-10T05:26:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4d4dad1c-6ab9-4211-bc9a-6188bdb638d8;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0089fbc9-5b2a-49a5-2ffc-08d83cede3ee
x-ms-traffictypediagnostic: DM6PR12MB3482:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB34823889D8DCCA5A37443287ED440@DM6PR12MB3482.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0KaipwiFZ9cEoVhfYEl9epFBcJhkncyCsKucINAAAdRo+mvZYURSQ590VF0pHCCEt+AOQSIi6nVsnmesS9iGTlrJYooFVoFtxE/zpASTjM0gsv6lAgI2gXBU70e7q46isZjoFixI8d0+d2nprqR9ID0PepS3tJaSvZ4Rcvc0qmClJTTTIybmBvK923dPHLh67T3Ge8RKUfudazhwkDq9Iz1QRImdgsrifSj0XHd/V/Yv4/LzSMzAhbHCAdo2rRODOrW6lbUjlzHKb2UTk1Fzlqmwe5rQcWGeuwsKB6BhVlEAYqMCeM8X8WED48O5n5ddDRY6aQY/f+rg9QpAE0JqXiDF3kveglY4kg9rrkczV69tqwO38mmr7E3ckwZxBHz
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2533.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(186003)(71200400001)(316002)(66446008)(66556008)(64756008)(5660300002)(8936002)(66946007)(2906002)(6636002)(52536014)(76116006)(478600001)(66476007)(110136005)(83380400001)(55016002)(26005)(33656002)(6506007)(7696005)(86362001)(53546011)(8676002)(9686003)(921003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: tU7JsVMo0fwmk0ZRubJ9ODQ0ZkEp4HegjVB371bSqzs3ly/RQKLcjMSXEVGBdX+szhLHI+IU+OfPxoXjezSbBLovLFpYvH9NqjSWtpOE5lg7xRObgimQo8nAYILInVKp3A/Cnb1W5c4yscqhEmwg7CaeWOejXqotJ2ylZFAlPtLzqjp6fBg3n37G7XNNSwlwA+URsjq7TZFTLRe9cwHwp2Z02QhOTPkegWYtXpkNVUhvKCs86/Ytrb1IWjwLqkBL8yKyg6BiYOcMwLr1O3rp+wl4kXBmQvKxKe5k+7UFJ8cHU58Chl+zuNBu6ODWufr8HNwMItWt8MzuEYNZklRdyLEjFUA76plJh5tC/p0iOvQr93aDZO15gqxG5ucFppNNafVhO4OdeBPTkdWQKvMIvQXeoXHHaLGz6IIwUkavvu3rcS9yeffoTD8nGvy4PF45162V2oimmyx9kXpVjJ6/vv7ShyTKmuGcklLVf7gBVao3kLOSAEZDVuQTHhhRSF6wEfjOM2oaKSXteXHvAbIbSa9Vqxgcpwn2Fh4SJTYjpql3HEEn0rxE5b6EnU2Rfx0QBzmV+wpYZry3dVq0Co3ijAoEf3h55cH2qHROECs4B/BDHLAEwilkEWZ7quq+hnQYYS2OtxI88VttVPB+I8q+ow==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2533.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0089fbc9-5b2a-49a5-2ffc-08d83cede3ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 05:26:10.1568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P+Ua4jaL9rDlSxy04nK9L8JDWiQt7xjFBusevL4Mb+vGwTo5Ik8jva2jLkpyOCmH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3482
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

[AMD Official Use Only - Internal Distribution Only]


Reviewed-by: DennisLi <Dennis.Li@amd.com>

Best Regards
Dennis Li
-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Monday, August 10, 2020 1:23 PM
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; Li, Dennis <Dennis.Li@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements, John <John.Clements@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add debugfs node to toggle ras error cnt harvest

Before ras recovery is issued, user could operate this debugfs node to enable/disable the harvest of all RAS IPs' ras error count registers, which will help keep hardware's registers'
status instead of cleaning up them.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index e6978b8e2143..31df6bf2dc1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1215,6 +1215,13 @@ static void amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_device *adev)
 	 */
 	debugfs_create_bool("auto_reboot", S_IWUGO | S_IRUGO, con->dir,
 				&con->reboot);
+
+	/*
+	 * User could set this not to clean up hardware's error count register
+	 * of RAS IPs during ras recovery.
+	 */
+	debugfs_create_bool("disable_ras_err_cnt_harvest", 0644,
+			con->dir, &con->disable_ras_err_cnt_harvest);
 }
 
 void amdgpu_ras_debugfs_create(struct amdgpu_device *adev,
--
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

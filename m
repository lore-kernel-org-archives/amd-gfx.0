Return-Path: <SRS0=Zv7j=A2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741B0C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 05:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E88020657
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2020 05:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IQxuLSes"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E88020657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99F306E378;
	Wed, 15 Jul 2020 05:12:20 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700070.outbound.protection.outlook.com [40.107.70.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815F56E378
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2020 05:12:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5brOfx4hAEGEmbfjp99SPX1XaLnn1KC4C6r+RiOfCC0GRPnz8GpPzvVrEluNWzfwWxZXg74jHSALp2wQw+Kiqc7r20m4kkdF4ZqW63IFXsmm6EbddJCkxSqZtxsIF3mXqEh7iq1HIibWI6fPZgjte8cxe3w72lUxp937AZNq7Cum6QuyH1sRDqUC6Wv5MELUfM2EZXaznEba7uPGz+/8t/j/i2thJMfY6O/7jLpIvLpcdVKeQRSn/wpw1AhlnpAlcpHQztvTSpq52ftFURoOtqIB8wugwmgfqyWnwqxRh7kJbINRHMVqVt4AnBjeddD1oITupoZfEVsgThosXJSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VugXiLJcc6mdRNzSEssi4kNmn7qeJsvJVsHu/tOhNwE=;
 b=H8az+CXRdvgA40G13fTR/FkJWHqKiEKcK4halhLiQMTAeK/0rlK2gQfxTXNLupAOCDZCw7BZ16sScsujR4XSM0EJ/fUdsOKVFAhCl1KwBl7WlerV4hd+yg7LB/uaGkyAV9v6oS+SvR1bRgOWp/OHFgUA9IQGZ7lbQw+7RQN26rY5sprz0N5PJh0ujttNmmn7KjGZSkoURBhKmz3X1q6TqhhHJHV/9MbjyCb5QZTf7grQ72rElWCrplk9xsCNbgCPdSUXfHeW1ReWBOVKj1cEaxQUbuYKy3VZaXQg5jtbrGeALhL7eYquyXr9SGjNQG/NKD3+jWPnoi0NiF8FCduRpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VugXiLJcc6mdRNzSEssi4kNmn7qeJsvJVsHu/tOhNwE=;
 b=IQxuLSesda6WddY3Icv+6WH7oe0FhP+5Yhpl0UM3b2VeDDUo+vu9ZF1u+SZZuTOiP1mg9IeK6wpMlaJnNMfkPx5iujdcAeBCvtO5v8zR/nK2B2umzBCil0qirfO9066yehfvsKNHY90puIe18XpFpEHcV7ztanicX3Pyc3wGSOY=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2504.namprd12.prod.outlook.com (2603:10b6:4:b5::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Wed, 15 Jul 2020 05:12:15 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.025; Wed, 15 Jul 2020
 05:12:15 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
Thread-Topic: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
Thread-Index: AQHWVsk3YqDT4uW8WU6QaqTmf+mVxKkIH0/w
Date: Wed, 15 Jul 2020 05:12:15 +0000
Message-ID: <DM6PR12MB2619AD3F3A4ACB3221558162E47E0@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200710145047.52383-1-nirmoy.das@amd.com>
In-Reply-To: <20200710145047.52383-1-nirmoy.das@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=48bf36f3-a129-4aaa-8de6-00007c43450f;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-07-15T05:11:48Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: adde2c96-bddb-4b79-65ef-08d8287da3b8
x-ms-traffictypediagnostic: DM5PR12MB2504:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB25048252AF3B310C8CDF9D13E47E0@DM5PR12MB2504.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yf5vUnMoV+BP+o04ETV3Tk1HvBh/iPKgOobz5uJZtxTs2SSNBkpOYV2+W7E105foPQFKLJMxlD+nI5Y4+oaRlCSJ35KnigOQYd2aG9nQcCzNTkxXophoTc5ReHROWvBw4jXiy7/rQOVuBVDCVnYLUYcqRGJ96qlksGZa2tfIzYiKxSyOpLg5Yr+bKhRDsnJYXKYk0o+Ftr0koOJh1TQ4kxVIZrwPIierZV/JAq9OpnFRkqod/KlI7amWIPZQwfQKbwaTYpYbkVxF6WKo4p10QjjV0MJqnZp42rwL8GgP8ckFmosiakOX/RiNnL7p54Y/wIL7425TnftiZ1XWBEf34g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(71200400001)(83380400001)(55016002)(7696005)(53546011)(478600001)(9686003)(6506007)(5660300002)(8936002)(8676002)(54906003)(86362001)(26005)(33656002)(110136005)(2906002)(66556008)(66446008)(66946007)(52536014)(64756008)(66476007)(316002)(76116006)(186003)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 1Yp5CNqWKz8mXolukWvoFEVemiwvR+PKfrM7OULP0olbZvk5zec8dlcVWpYI1QGHe+P6iPUlxh6BEPWv0tZ60LO6XvFwyEmRHSfeDrPwC+wgn4tbjxqlGROHMvieg5wLoKct/7zpM4jKuxF7Piz7gY2QULWA7/YjCDbTze7xtlrWDLygMdBGqvWpG6dbygKkk7w1yFELi0j3blgCYOqgknFsdNJT70ZWBiitYlqb7ElE9jD9MquCePF3I6hbcl+Bzsz02zgE8CfpFnpwSvEAAtgoSYy3OXxXKHxNyhj8BzyTZ3zIrNlARZ2TvKrtzcSjrd4obpcztOuykVuDMliQgJl0VRpvYJUfzd6gTxOpXOl63vBCP6zqnm2MzJ6nK53zwOH0NA6fdZb4GQlLpjAKowHTGnjzJJ2UtMGSGDkbyg0VceugP3S2U9lm4OFvIy3Ii45Jl/C3kyeTWfofsyEYv2aRSdn0HBbRTH0XXXA74+re7RpayV93su9xb+lIu87K
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adde2c96-bddb-4b79-65ef-08d8287da3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 05:12:15.4869 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uPggBtt7l1YXK3nOYqtUi79qwBLJstUMVc8PdktlVvtoX0cy39/CDgSVhuVCAhI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2504
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Acked-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
Sent: Friday, July 10, 2020 10:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
Subject: [PATCH] drm/amdgpu: do not disable SMU on vm reboot

For passthrough device,  we do baco reset after 1st vm boot so
if we disable SMU on 1st VM shutdown baco reset will fail for
2nd vm boot.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index d1adbc45d37b..07be61ce969a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1178,7 +1178,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
  * unfortunately we can't detect certain
  * hypervisors so just do this all the time.
  */
-adev->mp1_state = PP_MP1_STATE_UNLOAD;
+if (!amdgpu_passthrough(adev))
+adev->mp1_state = PP_MP1_STATE_UNLOAD;
 amdgpu_device_ip_suspend(adev);
 adev->mp1_state = PP_MP1_STATE_NONE;
 }
--
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

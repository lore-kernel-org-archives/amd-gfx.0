Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E7EC43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 18:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF6F820DD4
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 18:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TjToF8yQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF6F820DD4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DC7E6ED62;
	Fri, 18 Sep 2020 18:17:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 405E76ED62
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 18:17:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1zhgxSCZR5PYElT11KURLfTHtwEExvZumcsZJlSrLUNiNgqzq7H9xPffkhnqF96QPi8ByAp1xQSHdrFVLxB7ypTxPco645G63aqBgvt5vW55nI8NiTbaPrZYAvlEjcS6itgpZCPCvHFfGrk/EH83+DRpN9zTLjzSjs1r+Q4KbdIF/rMim3YAcE5j9IlOnTNN1q4fPqubDZS8i6PHjDpFxtrb9wEpm+/dGLLGEgEmg95xG2FJXzy4wZuE1adl8En1p+xC9Y9yOBHVZrfR/YHk8n+jndIh6fA+W4kuIYX1NTd20+7hGlAS236Gar4vMkEUK+JvwTBvZS3CA6VCsYQ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leMI26MjPuT80HiHPlhQCw8Hl1HbdvwTP3q1MLvJU+o=;
 b=j4hCuVgINmsch1EELIhGygxNKLjN1YjPNMDyb1lKSCkSKd98mJCfONHPBJphSF6dfm345qL7VB5iyjHU4GK5Oc7PdjwwkEZ+tQ7ud5lpBULPwtNcgvXjHDqndO5B1X+Ehr74jRD2eGMB4XTHk2Kbh/mD2eQOoG1EnW2J2FNGX0kch5oYprfT4A/DYv8R0k+wxDRnluCCfxOJbuQJDwsw0cADjmDSfwPvmYuKRk0LGmidG2vRMIMr7Tet+xLAKz7f0Swee+DEQCDouk2wIdFRA+z0uYOlNBEmvmfMwfFmCZeSIj0R8m9+CmoRfNjwFJsHXUNsp9RRCJ3+qxoRE3M6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=leMI26MjPuT80HiHPlhQCw8Hl1HbdvwTP3q1MLvJU+o=;
 b=TjToF8yQeFrilpYW5lUofsCW0v4bbzHquXRxAinhQO0Jq8lYGqeThRcgb5xi0OP7ATJzc9JBQvOL99HrRDAZdzV8ZlXknvpt6f7JtoTiVDDOOhQUfJDkptvFxAMgdPls1iDVrubkZ72NkPjk/pDtyLsSZMs3toDws/NmmQf6Dag=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB2873.namprd12.prod.outlook.com (2603:10b6:5:18a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.18; Fri, 18 Sep
 2020 18:17:33 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 18:17:33 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/1] drm/amdgpu: Fix handling of KFD initialization
 failures
Thread-Topic: [PATCH 1/1] drm/amdgpu: Fix handling of KFD initialization
 failures
Thread-Index: AQHWjKlbKmiuAxofG0Ws7tIRjr+khalutnVg
Date: Fri, 18 Sep 2020 18:17:32 +0000
Message-ID: <DM6PR12MB37212558D853E6E124195D9E853F0@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200917041620.16221-1-Felix.Kuehling@amd.com>
In-Reply-To: <20200917041620.16221-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-18T18:17:29Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=3041c9f1-8f3e-4aa8-a9a0-000018cae401;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-18T18:17:20Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 0ac70959-25be-470b-a485-000042080078
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-18T18:17:31Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: acc13624-f4a9-429e-88e4-0000cc8d1f94
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:1091:e932:9a22:4a8e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4f7c6d1b-880d-483e-d01b-08d85bff1cc1
x-ms-traffictypediagnostic: DM6PR12MB2873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2873D7C018EDD927D99C19BD853F0@DM6PR12MB2873.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFZdTKejjyCW+YSyh+EDpbmAP24w9y2kSbLsFybYQIHBokVNQsUVmbVejuFBEED6tMKLMPwqQVriqPXBjt3loodXaXzuAw2iayTuUY56o7qhbVk4jr/cGXcoU2FFiuG33ClnAsIla0ZCr3jTECrBP/gMeA15BW5fCyTKrTKuNwcuOUl1pOuCzKDlknT4gD0/Lek5cSp0jxkdQ+1bgXb135gnniWJJ8wL+I5EWymRcaRmMT4JybPr7EhijC+VBzeiwAVP61NiaUU9Ti8PONuNcZsBbKuFUhLLXn8t3QxQwjIqS2UFXBwJfqYxlMl91QbcgaQLc63ZbHdJpJ28mNy3GqGRz6iXfWdrjFCe3gVSgLw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(33656002)(186003)(66946007)(64756008)(66556008)(8676002)(86362001)(45080400002)(52536014)(66476007)(66446008)(71200400001)(7696005)(53546011)(6506007)(316002)(478600001)(76116006)(5660300002)(2906002)(8936002)(9686003)(55016002)(110136005)(966005)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: thAGupiJTHB5bHTCwSWRqjkRkf/zDgdTHB6FAlPAFKacPx2eDHgyMCHyJ1biFeq3srcpAxdU+HG2VExDiPw1MMfZhjWfMzI8nh5XdC5LrojCOlS4xExVsjEZt64gDxksacIWupIgFDgJdxyyojUA81Lh14SzoJDXXLaKhtymoY8EKtaug5z2316ePvk1wXB/UKIWKpQEjXV/KDiEhLCQXaHzPQeKgLj//17EwLb9U7dSlNgPz5OGrkymN7UmUFPZdKNlx+e58buQs2PX/WE5m7tzExZOEwj/gyiI4AmMMZjQGEBfjWr/CXqOdLq7U33SrKqLm4By/bQTTjUfNGPH+S3pj+goilfql43znj4eVYdLVRcBinrLulLznJl48Uq3lIk7LT2xs5hjepJIz/q0RDsYu7dN83MaGHPpyjz9PMbM7HSjicgdGXxONAnKsiDSK7LYyF3DZmajSvxJGY6Q27aDPEZxbRFGIH+6l4tjRrjELlaTnRvxN4KWHBLz8IBiNN+EUnv8khTC0nIidUr7s4HVxKha/HRfofnd6dPBLh0TIh/8RuigOmY1aP5f4rNR/GtXR06OCKddOzQS8q+pf5xwm+z3LECDNLtRFZGuueN7mJLTOyRVxfC+YQtbNQpiPPBrsfAPbKyGJ+RlWR9NA/YcUQ+H82k1QCHSBbw5wCKS4sh9T3jdyIOgnFSp2Pbd8PSywt6/LPYs8ekKGWP6+Q==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f7c6d1b-880d-483e-d01b-08d85bff1cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2020 18:17:32.8647 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9p2m3uHuEIO53j+GF4zTWdxNmu6q6H3+kH6GLWO6ZSy7RftXqO2SMLMd7HjtNAdBVxH99TkmhzCmNa5I5oEcTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2873
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

Sorry, I read this yesterday and forgot to reply.

Reviewed-by: Kent Russell <kent.russell@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Felix Kuehling
> Sent: Thursday, September 17, 2020 12:16 AM
> To: amd-gfx@lists.freedesktop.org
> Subject: [PATCH 1/1] drm/amdgpu: Fix handling of KFD initialization failures
> 
> Remember KFD module initializaton status in a global variable. Skip KFD
> device probing when the module was not initialized. Other amdgpu_amdkfd
> calls are then protected by the adev->kfd.dev check.
> 
> Also print a clear error message when KFD disables itself. Amdgpu
> continues its intialization even when KFD failed.
> 
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 11 ++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_module.c    |  1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index d58148f455dd..7f14461f7f40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -36,6 +36,8 @@
>   */
>  uint64_t amdgpu_amdkfd_total_mem_size;
> 
> +bool kfd_initialized;
> +
>  int amdgpu_amdkfd_init(void)
>  {
>  	struct sysinfo si;
> @@ -51,19 +53,26 @@ int amdgpu_amdkfd_init(void)
>  #else
>  	ret = -ENOENT;
>  #endif
> +	kfd_initialized = !ret;
> 
>  	return ret;
>  }
> 
>  void amdgpu_amdkfd_fini(void)
>  {
> -	kgd2kfd_exit();
> +	if (kfd_initialized) {
> +		kgd2kfd_exit();
> +		kfd_initialized = false;
> +	}
>  }
> 
>  void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev)
>  {
>  	bool vf = amdgpu_sriov_vf(adev);
> 
> +	if (!kfd_initialized)
> +		return;
> +
>  	adev->kfd.dev = kgd2kfd_probe((struct kgd_dev *)adev,
>  				      adev->pdev, adev->asic_type, vf);
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index b7b16adb0615..297484ca7d19 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -97,6 +97,7 @@ void kfd_chardev_exit(void)
>  	device_destroy(kfd_class, MKDEV(kfd_char_dev_major, 0));
>  	class_destroy(kfd_class);
>  	unregister_chrdev(kfd_char_dev_major, kfd_dev_name);
> +	kfd_device = NULL;
>  }
> 
>  struct device *kfd_chardev(void)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> index f4b7f7e6c40e..e5aa51f44dd5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> @@ -70,6 +70,7 @@ static int kfd_init(void)
>  err_topology:
>  	kfd_chardev_exit();
>  err_ioctl:
> +	pr_err("KFD is disabled due to module intialization failure\n");
>  	return err;
>  }
> 
> --
> 2.17.1
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7Cf9442a9688294ecc817808d85ac0
> 7cb4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637359130061923813&amp;
> sdata=ysgKdz8%2BuZY93Um5fFAXR5hopzDg0MhFbasV29mJO%2F0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

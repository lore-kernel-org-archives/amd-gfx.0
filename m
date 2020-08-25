Return-Path: <SRS0=LR/f=CD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5ADC433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 09:02:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA662067C
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2020 09:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hO1Ry2ZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA662067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8406E891;
	Tue, 25 Aug 2020 09:02:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF846E891
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2020 09:02:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHeK2D1TaAswFzjWwzFlWAV1y6n7GycQhDb9C3vUJ2aReYXy2J2vmpsZQFhhZS7Bkb5A5IYkd9ebhmbWYD4o5qGgfG25CcIp3gefudx8ggHR7bulf1GPq+Alf9cItxl8Jecz5hzeZZWl7sgz7xvJNazueYqVML9nxEzJh4HR4urrYkcPgr/hm3SuWCTr1tKly62Qs0crkDnecZlW6gprViKjhZBCeyrXsiq4l9cvZbXVWXKhTfFSgUeIsp/NMMxOxwQnNx3Iy9h0WRzAJuxnTyl0TMCBpjMLSi5Zfu78z1rgKICAzG68OHc7Soardnb5EMpvdI0zz9qDmvOmFaf1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6Km1VA6wLUoYxLoBH6FLyUnDL+o/DKbLUlnByx4um8=;
 b=Vp5G/IjupkGBBp3V3lzWFK2iUj/scIup+BS0Qn5FTVFruJ5BdHe0bIx+phhKOhpwZKQyV4mhx9AN4TPVpbFmgZJIowzUBten89vbJ+8xDuAP/kaYDBwUTRGDYrVaMFyGI9sOyZiMn0Szioy7AkNJLLcgCWXoVPfDgNU3sizRMO+yidv0zbxWLJRITE9YgET0yWMAWpuBnsc7Sl2dfRsLfIvKjd7tYf0GkqJtWpL+FQ5MowWN8z4nJPcYyPRucGMhtFP912ZSQUdpkoSx28cM4AvXJRd8rKUJ6bMJGQS/XKn6kkmG5N6/rrrOFQktvFnvGYlKaDQcEowhItb5Ia7dVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6Km1VA6wLUoYxLoBH6FLyUnDL+o/DKbLUlnByx4um8=;
 b=hO1Ry2ZXAZUrMWHiDFijWgw151VRHxmEaGyIz3aWfZW7nhfjobx+SOGZnOZ1orwQeuOm9O/vXoTuI7l4BJU5Pv+HmJyS5XXDd/7bWjvBtmMj4SAq60TKeE9+grLhHWzRIBdffXZgfP4eJskIBpJ4HQQvj+dMy/emcF8WGZO9FeY=
Received: from BYAPR12MB2888.namprd12.prod.outlook.com (2603:10b6:a03:137::24)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Tue, 25 Aug
 2020 09:02:46 +0000
Received: from BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf]) by BYAPR12MB2888.namprd12.prod.outlook.com
 ([fe80::6ce3:37a4:5c5b:c9bf%4]) with mapi id 15.20.3305.031; Tue, 25 Aug 2020
 09:02:46 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: use MODE1 reset for navy_flounder by default
Thread-Topic: [PATCH] drm/amdgpu: use MODE1 reset for navy_flounder by default
Thread-Index: AQHWerWSG0jgjad/CU2x3Ul3cmNY8KlIh2CA
Date: Tue, 25 Aug 2020 09:02:46 +0000
Message-ID: <BYAPR12MB2888ADD59D1CF28F51286A8DB0570@BYAPR12MB2888.namprd12.prod.outlook.com>
References: <20200825075836.2142-1-Jiansong.Chen@amd.com>
In-Reply-To: <20200825075836.2142-1-Jiansong.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-08-25T09:02:34Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4b45a905-7b45-46b5-81d5-0000e3b78f8d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-08-25T09:02:20Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: aae812cc-9c6b-4bbd-9a2c-0000ff5bf8fc
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-08-25T09:02:38Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 544c38d4-da66-43c3-bdaf-000083939f45
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3881f00f-0ca7-495a-4eb2-08d848d5a291
x-ms-traffictypediagnostic: BY5PR12MB4065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB40654854944A56E3304D2EB4B0570@BY5PR12MB4065.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qTY3hTtt0BUVjvJmCF7OHTxeNfXq7Urwbeaqa/F16oKAX8jqEtmuQ3xB3o1PHG5rgQEaAGuwrXFx+Rak9NKy7W0ZRuhzj5+Q11jLLvrJgFInXcaz6dDCZsXGY7fxDHnv9CWtQKNPTbRAPUbTgVYkHiWrslSWgOHoJyRL8mrxesrCHVmy34z6C/kHDrlRkO7iwCNNDkmgJO6+SXJ6pwGDjw+EVo+rVDEXQnIK+c6Yy596VrntSVlxh/94+GQAITgZzsrAWZzDLeHiZS0Jqu/gUGSeNTM+NM2IGm9H0Ep9TY6MOL1HoH9rTAvMl+MeIzCM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2888.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(66446008)(64756008)(66476007)(66556008)(76116006)(66946007)(52536014)(26005)(5660300002)(8936002)(110136005)(53546011)(6506007)(2906002)(8676002)(478600001)(9686003)(86362001)(55016002)(71200400001)(316002)(4744005)(4326008)(186003)(7696005)(33656002)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: cCs+z1c/YvQF00lqvVweRv8UBSBubJgr678Kku4d2lebORi0LSkCuBl8LpqfVQQVMWSsfSdtj+qHH3rT2BBjcLh1TL4onaZ7ZOGt9F65xOAmja15TPmYDqQFWvh79T/x7A/mEFsXrzBTZ9hCqZq1hyRdsCO8899ePd1Zpn8T/Z6zLojsSS8DLXa5vwOWFPCfcoaJSsDeLvlkD91rRx0u9uHE+5whIO8rzJeasgT96j377ieh2FMUSM19YDiYlaDucpz+KY2J2I2l759SnxnjPr2l1xfiB1NnHp78vqTpHWdCM8Qn8DPOhN+jJnk1lDVeNb/J6qF0y8Mn74XhET5eBeo9apWIAqUpOxjb1fj/GjTgrKxb3Nusw6HT3N8gLFwJjWE1isN0HnY3dysRzH8e8lIAvJOk/+D2kIW6BkoTi1msGvGJ1Zecoad8SnNgoq0LPld0ohG8gtQbgKRIj8LvCkYgmCCeAlbGz3niSRoaxUbJZuKTwDpZspz7Fh2D8dmi0TzuO79loU3LicDzwPCZt6A0PsTseXMzbeXYDRgZhMFASoFusynQ4TylNkDES1x0t3izX3/5Ie9U8XxXSzPyMdPUD9lCtwnv3vLwxgYPq74cYLfvVQ+TkgDIcItiWIPlvrolvE4d9NPMypVlo9QDFg==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2888.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3881f00f-0ca7-495a-4eb2-08d848d5a291
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2020 09:02:46.3302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjqPCU7oYUs2sXDAGK+k28fbQJ0HPJJgp2JJzPw732dBi3f0HGy1cHTOI/Gg3nOw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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
Cc: "Chen, Jiansong \(Simon\)" <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Jiansong Chen <Jiansong.Chen@amd.com>
> Sent: Tuesday, August 25, 2020 3:59 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chen, Jiansong (Simon)
> <Jiansong.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: use MODE1 reset for navy_flounder by default
> 
> Switch default gpu reset method to MODE1 for navy_flounder.
> 
> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
> Change-Id: I99b2d3ac04352142e288877f3b6c3138d0efd4bc
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c
> b/drivers/gpu/drm/amd/amdgpu/nv.c index 33a6d2d5fc16..4d1402356262
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -364,6 +364,7 @@ nv_asic_reset_method(struct amdgpu_device *adev)
> 
>  	switch (adev->asic_type) {
>  	case CHIP_SIENNA_CICHLID:
> +	case CHIP_NAVY_FLOUNDER:
>  		return AMD_RESET_METHOD_MODE1;
>  	default:
>  		if (smu_baco_is_support(smu))
> --
> 2.25.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

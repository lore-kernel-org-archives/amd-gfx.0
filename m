Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2EDC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 03:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8036E20715
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 03:29:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qsnMEP4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8036E20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5F886E2D1;
	Fri, 14 Aug 2020 03:29:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A0856E2D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 03:29:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgRIDWfmElN5JoHTfkYXvAyKR1FITsm4TnOqOT9Gyb8ZUHxifBbzsBXim5mGF7JDaXBRYNA72j/x91bQ/GbUA51Y0GrqDVuQq95hxnENJyk3o8AcrT6CGnvsFI5SYQ7HLA0UVZxi7ZOOCuVAnT/KIz7r3YNLoC1OOY9jR/Oo6HY1RqpsT5K44dX1kfmnZ5veUAy3dSeC5EFMDVqDzis+HObLDODZdYdnNDqgm61nJ9EcggImBLBYKstdxy5CG6yCP/6Vg9HHqtlUqjPPVuReVFvV1UBCJzm0qh79FKQ5BBJWxbbnVFFIJKny0UAHFeQ6atn+y99VUYFTrKvHA1yyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKp4npEy7oiLHJm0hTRssM+dLGEw9iU7IzOisu1M2BE=;
 b=EFKjs1tct2dVRZvkkLu2xqGXBAaF0pWgE9p4Vdv+hBi2Oa58qfulWAcPDD/xW+bS9aZ/ChN3KbxbDubuvCu9pNPr1B19cIEkzXf30k4Rc56xkXb2iaViD/p4XYSs/uuCrJ0QZfn+GBSnD04553foJ2No/2bu7OaIvMJLpMlY2p2sCkwU9gVmuUO2+LXIsz14Lz325xpFV9lg32plsy4JbjvMWJ6Yu36/EgN/AMqH2Y/BgLRPCgEidsjKrAjlLuxHxSL6bL1dq9La0JCVMDiSs+9SUXgXNOdqDWvDdXtYYtWv7XtRA4qI5IWR4oo8av27Y6VlAmBnCbaB3ppMoa1F/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKp4npEy7oiLHJm0hTRssM+dLGEw9iU7IzOisu1M2BE=;
 b=qsnMEP4qxAvADN74L5PMK5gL66nIT92Ja6YdXNybmvMg8I9iYhXulVDKvwvS0Mk0LP4zIsJrLx2AVv+q8UVHPv2U2YLStk2oPBD5JaoYYNmTATICKUNAcyvMBbzo5KNu2blknFT13MiUkzSGVN5K86ah9pzpYxTiSfPqo/AuOlk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2889.namprd12.prod.outlook.com (2603:10b6:5:18a::26) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.20; Fri, 14 Aug 2020 03:29:29 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 03:29:29 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Matt Coffin <mcoffin13@gmail.com>, "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for
 pp_od_clk_voltage
Thread-Topic: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for
 pp_od_clk_voltage
Thread-Index: AQHWcdiZxM5xn8IriEOqFcnVi/Q5tqk23XsAgAAQr4CAAAOPQA==
Date: Fri, 14 Aug 2020 03:29:29 +0000
Message-ID: <DM6PR12MB261947DBE9ABC3A2B50B0EE4E4400@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20200814011528.10862-1-mcoffin13@gmail.com>
 <DM5PR12MB2533F63FBEBAB56E2A78268CED400@DM5PR12MB2533.namprd12.prod.outlook.com>
 <48422f0f-31e4-7296-7dd8-1051f1ff5a5c@gmail.com>
In-Reply-To: <48422f0f-31e4-7296-7dd8-1051f1ff5a5c@gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-Mentions: Dennis.Li@amd.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=b9bf080b-c37f-4269-b915-f0d6834b3802;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-08-14T03:26:33Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [58.247.170.242]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e616958-6557-4076-c9cc-08d8400240d8
x-ms-traffictypediagnostic: DM6PR12MB2889:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB28891B06EBF8A26DDF9BFF04E4400@DM6PR12MB2889.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRBvsIgAmDqE3lIy4t+J/AWiRdST5RlmLrwKGvkLwLEo9kuBosiR/l+FbKEhXSzqjkr8vOZSRBfG855IMnsWkk9hT6o3Mz6FsPd2kJ9zkwhUTh/rGjloRk6ZEG4UjNrIjbVbRbgYC7WedJWmBQtDPTGZ33i2UDWggbr+uYdo8SfGWSiqoK/diCVNYFiXi9D1nA7McSR7NqNKI7bG4KRT0txPGG+AoP+ifsWb/RVp6ZnzeZr7vsqQOd4Ed9XUdbk6GEwgiL9VsvklvOpQ6I87T/vBNziCKcnmK3HF/iVsRSFfr1lDuVTSDiR73rLer3ngfR8aPGlQHQIX+nXOJFuwI0cuRDJMvfMPfoMQXROhfpd1YyC2g9VOyiLFl510CoEffRghMCRRIN3/vzN9mBk0oQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(83080400001)(316002)(45080400002)(478600001)(5660300002)(52536014)(9686003)(110136005)(2906002)(4326008)(55016002)(71200400001)(8676002)(66556008)(66946007)(86362001)(83380400001)(8936002)(7696005)(66446008)(64756008)(26005)(66476007)(966005)(33656002)(186003)(53546011)(6506007)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: g4gH+ItzFQdAGj5/LDj8bglwxKIUNCuCPnjo9OgZWjFOi7TJ9uvXO+1eXlozVUIQxjFkATEVfdVArpomFbG3BqtKzjRa4UdIGTbisTauZ/hZVuNKfBq7HP6BMdBZwufitsbzMZAkcANxSeb2/0dvQLXrpGPJQlx1nDZqMSlbq4zMWZmhCaRSExCx0ra7sjgAPIiu5+eqkH7i+Vjl2IaH5av08/eYEaMy6iJeUIVBb3OjkeLb03rF26ouigA/esh0fKD3t2I+ywRK6uX1Hvr63cmcfsFtZj6NBAmB4nhq0RUfN4GH5mHh/49uRuX1TDmZ97MZVJx55gZsIrbi8JsyNJKrtVrONo5xieK4whoA1OfQ97VnOM31uMicvcrKt4unIhKYBtbaTpiMDAx2OENQ0tYbSWSTJCqT4oLNCdfinx26QbdWf1SSVU2TemsBaQ9TeEWrwgzO6PiEhw03WuhMD0ajZZS/zyd51g2OsyiZBkt7GtwDOEczILopv+OpsX6iqvdaX1SAabUvZdOgdM+jyIYW/gX3OfJhOBelr+dRIkGwYBYlIru9MU2RtCF9dbX2Ir6kKxiCmJXM9B4VEkSoXf1MZDMaQwA7+a2ECTrBxnxtlMql+XsrVZnJ4fq6OUo/IfRhVXeg8FMvY3tgb94wgQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e616958-6557-4076-c9cc-08d8400240d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 03:29:29.3747 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ekVME7vslH76MXty7lHN1sY37RikGRVlxQdi9C+VcfloP3goDmqM6M+jzJq56LQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2889
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
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Thanks for catching this. The patch is reviewed-by: Evan Quan <evan.quan@amd.com>
I have the same copy as Matt. @Li, Dennis maybe you were working on an old copy?

BR
Evan
-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Matt Coffin
Sent: Friday, August 14, 2020 11:14 AM
To: Li, Dennis <Dennis.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Koenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for pp_od_clk_voltage

Hey Dennis,



Thanks for the testing.



I'm having some issues reproducing, as that command is working fine for me in sh, bash, and zsh. So just to confirm a few things while I look at it...



1. What kind of SMU is on whatever card you're testing on? Looks like smu_v11+ to me?

2. (shouldn't matter if you're right about which -EINVAL return is being hit), but is OverDrive enabled?

3. Is this based off of latest amd-staging-drm-next?



This is the code block I'm seeing on the HEAD of alex's branch... which is a bit different from what you pasted.



This error also happens **before** the infinite loop I was fixing with this patch, but might as well get both birds with one stone if there's still an issue.



while (tmp_str[0]) {

        sub_str = strsep(&tmp_str, delimiter);

        ret = kstrtol(sub_str, 0, &parameter[parameter_size]);

        if (ret)

                return -EINVAL;

        parameter_size++;



        while (isspace(*tmp_str))

                tmp_str++;

}

On 8/13/20 8:14 PM, Li, Dennis wrote:
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi, Matt,
>       With your change, I still could reproduce the following issue:
>
> # echo "s 1 1900" > /sys/class/drm/card0/device/pp_od_clk_voltage
> bash: echo: write error: Invalid argument
>
>      I found that it is related the following lines code, could you help double check it?
>
> while ((sub_str = strsep(&tmp_str, delimiter)) != NULL) {  // sub_str will be empty string
> ret = kstrtol(sub_str, 0, &parameter[parameter_size]);
> if (ret)
> return -EINVAL; // return here
> parameter_size++;
>
> while (isspace(*tmp_str))
> tmp_str++;
> }
>
> Best Regards
> Dennis Li
> -----Original Message-----
> From: Matt Coffin <mcoffin13@gmail.com>
> Sent: Friday, August 14, 2020 9:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Li, Dennis
> <Dennis.Li@amd.com>; Matt Coffin <mcoffin13@gmail.com>
> Subject: [PATCH] drm/amdgpu: Fix incorrect return value in sysfs for
> pp_od_clk_voltage
>
> The changes in edad8312cbbf9a33c86873fc4093664f150dd5c1 introduced an issue with the sysfs interface for pp_od_clk_voltage. It overwrites the return value to 0 when it calls another function, then returns 0. The intended behavior is that a positive return value indicates the number of bytes from the buffer that you processed in that call.
>
> With the 0 return value, clients would submit the same value to be written over and over again, resulting in an infinite loop.
>
> This is resolved by returning the count of bytes read (in this case the whole message), when the desired return is 0 (success).
>
> Fixes: edad8312cbbf ("drm/amdgpu: fix system hang issue during GPU")
> Bug:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitl
> ab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1245&amp;data=02%7C01%7C
> evan.quan%40amd.com%7C08991e3858f144a4dd0908d840001324%7C3dd8961fe4884
> e608e11a82d994e183d%7C0%7C0%7C637329716385273288&amp;sdata=w%2FBlX8CpG
> 0TfTYd1InX8Z%2FMBrRbVu%2FT4zWehWKHClCE%3D&amp;reserved=0
> Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> index 1705e328c6fc..f00c7ed361d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> @@ -937,7 +937,11 @@ static ssize_t
> amdgpu_set_pp_od_clk_voltage(struct device *dev,
>
>  pro_end:
>  up_read(&adev->reset_sem);
> -return ret;
> +if (ret) {
> +return ret;
> +} else {
> +return count;
> +}
>  }
>
>  static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
> --
> 2.28.0
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cevan.quan%40amd.com%7C08991e3858f144a4dd0908d840001324%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637329716385273288&amp;sdata=IbsPW7%2Fr2HXLxKK4%2FOb6fqFmZXtyivbTsP9ftd7P2Dw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

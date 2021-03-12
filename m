Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2D4C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 18:00:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B4E64F3F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 18:00:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B4E64F3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FE06EC11;
	Fri, 12 Mar 2021 18:00:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31F9E6EB60
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 18:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Htlc6kbnc4MqCCgXPes/dLHcmjWDFMLzEYQur/AWgWxEYJLsUWscQb2at5NcJe+CoywA8CfcroHD3t7/nOoGRjWcFlEYXMY05pIBjRywUGPn0Jglp9+wDlAsoUj48xBXVBpnmqSTmBbnVdeXqVOSY8Tnubfxz4Bob8z32+0gpi7kvFs0Yny4igvAN3Tizv6zC4GmLKksjQIVNRQ+DpHaP4rIEVVVV7rupgR8ycJwhAVbHuBrWhxztaCjGSKcmAFAdDrAuLnJJK6WhXb7hmOKA0LPEHbn0as0fHkxZ2zSsyNGy9nzP6IsramuXRD6+msfuvBJTw4cb/M4YO1WhZutSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIzZa0e1/KFFRkHNpEer/d2NKD1ksseC6VbBYNle9Hs=;
 b=PL5LPzwhjiQr0lieie+YLP9aFIO34JKWZyDjcP/ilaN63yqbIeoF7Fd5eUCK/ye1WOCKskt2SrD7jcRxck+gkMqxJgMFu543btn3jhYIsTcM6denPbI81kk3fmVcEXxG8JuqEVO24AzcvGOa2UntA4g4gj76UZwZEZ0s+Z+z92DtH1NDD4JuU6v2Jfh2xkjhwGbgjQdt73Vjjts0XevtsOT1JpnRtA0rFMDa4OYcj9dyJFzEABA/Sp9dwlhFcyeDkuht41KAkmJOOT0YtBu00ooWKEV4haBxcT6jwLobJLWQe47OCcCh7ORNZ2PMjRZCUjGTeXVFcesWB+aT9D+BxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GIzZa0e1/KFFRkHNpEer/d2NKD1ksseC6VbBYNle9Hs=;
 b=ThhyOBjvlL+iLMGJyADB+LgSVXSdmgi4ip0zYud7tZzsG8M3ZUTKJ0hZkF6fvas7noGiZjYPzWhNA6xycQjvQ5dlpQXkBKxgJcnEHXgWWDR+GMJX45SmWD6dqD1ifKIq+APL8LInWthd5YSNQDrguCKzs5X2TtEWgFpT+pJAOt4=
Received: from DM6PR12MB3835.namprd12.prod.outlook.com (2603:10b6:5:1c7::12)
 by DM6PR12MB3401.namprd12.prod.outlook.com (2603:10b6:5:39::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 12 Mar
 2021 18:00:29 +0000
Received: from DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9]) by DM6PR12MB3835.namprd12.prod.outlook.com
 ([fe80::102:2c9a:54ce:63e9%6]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 18:00:29 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Quan, Evan" <Evan.Quan@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Topic: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough
 configuration
Thread-Index: AQHXFpo1/qViy9Iqmk2vLKn/BFJ85qp/tiyAgACmLouAAATrAIAAFoTQgAAbsQCAAAzoIA==
Date: Fri, 12 Mar 2021 18:00:29 +0000
Message-ID: <DM6PR12MB3835E9D3AE2F8738D54B4B1BF46F9@DM6PR12MB3835.namprd12.prod.outlook.com>
References: <20210311171548.10671-1-shaoyun.liu@amd.com>,
 <MN2PR12MB45495AB3BB248A637F218F38976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
 <DM6PR12MB3835F2F751F9A0F52009CC5EF46F9@DM6PR12MB3835.namprd12.prod.outlook.com>
 <MN2PR12MB45495A8F65EBB79F58CCA142976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
 <DM6PR12MB383506A71D683EFED22BE0ABF46F9@DM6PR12MB3835.namprd12.prod.outlook.com>
 <MN2PR12MB454920FC21F6A0586C61D341976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB454920FC21F6A0586C61D341976F9@MN2PR12MB4549.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T18:00:27Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=ff272384-ee4d-41d9-8a3c-8f064fc901a2;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8dd372a2-0f3e-4cc4-1fce-08d8e580b919
x-ms-traffictypediagnostic: DM6PR12MB3401:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB340184D3B3C4AF173152FB2BF46F9@DM6PR12MB3401.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GfsC8DDFmMs5r3MLFF1AeELBKNdQSi5uYrnvX81aBuNDzdeplbjmd7X7dt1HstknK11RyBob0v7jj2a2dZ16+i3b5B95kiGqcQqLXyWeUNhx7/+G5JBUCPX1BNN6z3sdwVC92+p3FMqFRrZFTbYcnFQuw+N2gUgVLMB2bhI2AQIMvYtf+Io6oxvIYYjmQm3Sj3KudvfZ4Jc5Use94nPBIEnYH7KBhfe31RwlyqXpmayHGnpCjiGeiHXz/jVm7Axn8huKr5VHZeSt2L+tiHfcmog+oRPKqN3GmOguRZMpnw7W9QQiHS0RQb/nnEULzIcifVhYSAJVcFY0X+p72QCaqIN9Tuz7GWF2a0popc5jiXPmoUPoeAiTbjjt31wFlLAWhXxLFOT03Y9p1vLHupvlhLpf/aC/kda0EDas3adOz1Jmfjc0fQDPt574vtis8hau4CkgdkaS2QEKm7Ar3gfrOHORR4jhKsg8+jIKqUUy1u6Alxdhbq7rXDZ55fxy9CaXevGFiz6hBOdjs4xWexnGuRV+A1XCD0Q2WXb6KRI9G/c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3835.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(166002)(66476007)(76116006)(8676002)(64756008)(66446008)(8936002)(66946007)(7696005)(53546011)(478600001)(66556008)(26005)(45080400002)(6506007)(966005)(186003)(9686003)(33656002)(2906002)(6636002)(83380400001)(5660300002)(110136005)(86362001)(52536014)(55016002)(316002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Wve/nS0oGEabXiFCA7bXElHDOukUXlzJ1FWA/0wmnQdpaDQJAC3R/U4GkznT?=
 =?us-ascii?Q?i/vq5HF67QUQfn8JepFRzhHS+nn1xod+SW9BUrPPR4GqRSkRV2cSv/S0Okkl?=
 =?us-ascii?Q?qbfGaW2j++cljNU2QPMUlr+cOFfNvfHPDuBi6qXrs7LI7+iwt0daxsVaZL36?=
 =?us-ascii?Q?ngKMpFZ/QlVrv+QI3+NcnEnJLRmJo+/nzCB8FO6yrJwmaxgH/LNzmnNqNe5i?=
 =?us-ascii?Q?YkEU5Fq0YiK+wowyya3qbUqyUIiiHcn+NRHKXvf1zA2xShlOHJH88AFirG6G?=
 =?us-ascii?Q?wxQJaL1LCh8y5xS8ZL+RDBu3bXijQQXd1tzvyMNcX8jXRpWwbPrUvtOeyn+h?=
 =?us-ascii?Q?S6W5QWtznWvOFQmwYl18gWslnRA6C1WvhFQYcG8L9945EKIdnrpCJMiAm1tp?=
 =?us-ascii?Q?zJKt2p7nA95YO7DRuujK813Nal1QMvJ/r3E4n2ecmA8GxgYFOz9jdCjxqEaR?=
 =?us-ascii?Q?4fn2sMZk0MDhcDrLZmz2Nt7Kw9wnQcHazjlMj/h3Ry+httQd74MJgzA0gbSC?=
 =?us-ascii?Q?IYmwpOo1mDE2owHtoJuilQSMrnCyrb0SfdyaMxbtgqjlOEgEK3PJfhJiO/fI?=
 =?us-ascii?Q?yW3/FMTRUnotoSU5jmZ8zxXJRVID4Bc+U0JJSB2RTjZjs5Aydc+CMlw12/aj?=
 =?us-ascii?Q?lNOlDir3rtUbOXMuiYYgXUVr8Y8LL7fIX/uNvm8/04/6I4C41/9gtiQzlUkY?=
 =?us-ascii?Q?T0ePvLW6jfkGp5LMALBu6zA+ek2v5Hu0xeWn7qQ100vIlElP0nGlPNptoCxk?=
 =?us-ascii?Q?Py9NFxlGwcIPwi952n1WDsLRewqyHvfRTjot5LBTqaIwSj8tpPLYbpaX3aDb?=
 =?us-ascii?Q?ahNZbMnSBMNu0ACGYGtfkaa16pIJr7BhsnB4qlC6m4Kj2rOObzHs3Xwg2MCy?=
 =?us-ascii?Q?lRgpzSaWuNHus8ytmBlojDf005xgp47zQkc/DHOMMRecwvvrKtHNyLyCHtgB?=
 =?us-ascii?Q?xN65osWC0WD2A0Ksjrh4noURF1JQ/29qOxNnAb/2ue+P+oT8FSLSm6O5/Zyu?=
 =?us-ascii?Q?qlFH3WupuXfQlEQWcwbujYeu8ILggGLjmdsTIr55+qBgaCMP6BSaf6MpVOcF?=
 =?us-ascii?Q?DtLzEmLdL/W4jgp/AOfU9p9/fGu+afLuLGGyuKBRdPxcGMjSMlsqOaPQWNg9?=
 =?us-ascii?Q?c58xd9wApmvGwA7j9MoH79P87yiCmDarVZCNuVQj51NQ55aQMFimVNA0ZP5k?=
 =?us-ascii?Q?LEjIge1zChh+Zoj0s9dqg+KX5gkQMM0bWFvGrUBajBAdYlC5PF1nhKpeIXPu?=
 =?us-ascii?Q?RaECrX8+OcgieVERAXUeij2VBH5h0PcxiHeVVkOLY4CiBauwrwsAuU/90LfT?=
 =?us-ascii?Q?Tg1OV1ZksfdnCRsGUHO4jNHl?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3835.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd372a2-0f3e-4cc4-1fce-08d8e580b919
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 18:00:29.4952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h315VuJcC0gFmpFMo94TTZp95BIvowvLqlDhcfX40PEGrXpt9zLRYiSbZsvloJZtFx82FLaLnbguSSayPQJKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3401
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
Content-Type: multipart/mixed; boundary="===============1642571439=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1642571439==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB3835E9D3AE2F8738D54B4B1BF46F9DM6PR12MB3835namp_"

--_000_DM6PR12MB3835E9D3AE2F8738D54B4B1BF46F9DM6PR12MB3835namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

Hi , Lijo
For now we  only enable this light sbr feature for SMU  on XGMI + passthrou=
gh for Arcturus since this is the use case our customer is required and  we=
 only verified in this configuration .  I feel  it's more reasonable to kee=
p the logic of enable/disable in amdgpu side instead in SMU internally.   W=
e might need to support  the SBR in bare-metal mode  in the future .  Also =
 we plan to use this feature  in future ASIC if the default HW reset method=
 doesn't works stable.   Your suggestion will need to move the enable/disab=
le logic into SMU internally which valid our original design.

Regards
Shaoyun.liu


From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, March 12, 2021 11:54 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org; Quan=
, Evan <Evan.Quan@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration


[AMD Public Use]

Looks like this can be handled during post_init. It will be called as smu_p=
ost_init() happening during late_init part of smu block. You can check vang=
ogh or navi examples on how to add your implementation.

Thanks,
Lijo

From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, March 12, 2021 8:57 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Quan, Evan <Evan=
.Quan@amd.com<mailto:Evan.Quan@amd.com>>; Zhang, Hawking <Hawking.Zhang@amd=
.com<mailto:Hawking.Zhang@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration


[AMD Public Use]

I don't like to add this set_light_sbr into ppt_funcs  either , but please =
check current swsmu  code structure ,  there is no asic specific swsmu late=
 init function  and  there is no direct routine form  amdgpu_smu.c to smu_v=
11_0.c either . It requires  smu common code ->ppt_func -> smu_v11_0 for Ar=
cturus  specific function .  So unless SMU and  PPT have a major re-structu=
re , set_light_sbr need to go through ppt_func for now,  I think I  better =
 leave this  re-structure task to SMU and  PPT owner in the future .

Add  SMU and  PPT code owner  Hawking  and Quan for comments .

Regards
Shaoyun.liu


From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Friday, March 12, 2021 8:55 AM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration


[AMD Public Use]

We want to keep ppt_funcs minimal. Adding everything to ppt_funcs and keepi=
ng as NULL is not the right way. Please keep the code to arcturus.

Thanks,
Lijo

From: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Sent: Friday, March 12, 2021 7:21 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration

Thanks for the comments. This light sbr solution could be applied to other =
asic as well. In swsmu code, It will check whether the function pointer set=
_light_sbr is valid before real call the function. So for other asics if th=
e smu apply the same change, just add the ppt function pointer and we will =
have this support without further code change.

Thanks
Shaoyun.liu

________________________________
From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: March 11, 2021 10:42 PM
To: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>; amd-gfx=
@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists=
.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Subject: RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough confi=
guration

[AMD Public Use]

We don't need this as a generic ppt_func. Reset functionalities are changin=
g over programs and this could be valid only for Arcturus. Please move it t=
o Arcturus swsmu late init.

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> On Behalf Of shaoyunl
Sent: Thursday, March 11, 2021 10:46 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com<mailto:Shaoyun.Liu@amd.com>>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configura=
tion

This is to fix the commit dda9bbb26c7 where it only enable the light SMU on=
 normal device init. This feature actually need to be enabled after ASIC be=
en reset as well.

Signed-off-by: shaoyunl <shaoyun.liu@amd.com<mailto:shaoyun.liu@amd.com>>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index cada3e77c7d5..fb775a9c0db1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
         if (r)
                 DRM_ERROR("enable mgpu fan boost failed (%d).\n", r);

+       /* For XGMI + passthrough configuration , enable light SBR */
+       if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes >=
 1)
+               smu_set_light_sbr(&adev->smu, true);

         if (adev->gmc.xgmi.num_physical_nodes > 1) {
                 mutex_lock(&mgpu_info.mutex);
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
         if (amdgpu_device_cache_pci_state(adev->pdev))
                 pci_restore_state(pdev);

-       /* Enable lightSBR on SMU in passthrough + xgmi configuration */
-       if (amdgpu_passthrough(adev) && adev->gmc.xgmi.num_physical_nodes >=
 1)
-               smu_set_light_sbr(&adev->smu, true);
-
         if (adev->gmc.xgmi.pending_reset)
                 queue_delayed_work(system_wq, &mgpu_info.delayed_reset_wor=
k,
                                    msecs_to_jiffies(AMDGPU_RESUME_MS));
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Clijo.laz=
ar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe4884e608e11a82d9=
94e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3D7nd=
htOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;reserved=3D0

--_000_DM6PR12MB3835E9D3AE2F8738D54B4B1BF46F9DM6PR12MB3835namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader87abd423, li.msipheader87abd423, div.msipheader87abd423
	{mso-style-name:msipheader87abd423;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheader87abd423" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hi , Lijo <o:p></o:p></p>
<p class=3D"MsoNormal">For now we &nbsp;only enable this light sbr feature =
for SMU&nbsp; on XGMI + passthrough for Arcturus since this is the use case=
 our customer is required and&nbsp; we only verified in this configuration =
. &nbsp;I feel &nbsp;it&#8217;s more reasonable to keep the logic
 of enable/disable in amdgpu side instead in SMU internally. &nbsp;&nbsp;We=
 might need to support &nbsp;the SBR in bare-metal mode &nbsp;in the future=
 .&nbsp; Also&nbsp; we plan to use this feature &nbsp;in future ASIC if the=
 default HW reset method doesn&#8217;t works stable. &nbsp;&nbsp;Your sugge=
stion will
 need to move the enable/disable logic into SMU internally which valid our =
original design.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shaoyun.liu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Friday, March 12, 2021 11:54 AM<br>
<b>To:</b> Liu, Shaoyun &lt;Shaoyun.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Zhang, Hawking &lt;Hawking.Z=
hang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Looks like this can be handled during post_init. It =
will be called as smu_post_init() happening during late_init part of smu bl=
ock. You can check vangogh or navi examples on how to add your implementati=
on.<o:p></o:p></p>
<p class=3D"MsoNormal"><br>
Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shao=
yun.Liu@amd.com">Shaoyun.Liu@amd.com</a>&gt;
<br>
<b>Sent:</b> Friday, March 12, 2021 8:57 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Quan, Evan &lt;<a href=3D"mailto:Evan.Quan@amd.com">Evan.Quan@amd.=
com</a>&gt;; Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com">Ha=
wking.Zhang@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader87abd423" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I don&#8217;t like to add this set_light_sbr into pp=
t_funcs &nbsp;either , but please check current swsmu &nbsp;code structure =
, &nbsp;there is no asic specific swsmu late init function&nbsp; and &nbsp;=
there is no direct routine form&nbsp; amdgpu_smu.c to smu_v11_0.c either
 . It requires &nbsp;smu common code -&gt;ppt_func -&gt; smu_v11_0 for Arct=
urus &nbsp;specific function .&nbsp; So unless SMU and&nbsp; PPT have a maj=
or re-structure , set_light_sbr need to go through ppt_func for now,&nbsp; =
I think I &nbsp;better &nbsp;leave this &nbsp;re-structure task to SMU and&=
nbsp; PPT
 owner in the future . <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add &nbsp;SMU and&nbsp; PPT code owner &nbsp;Hawking=
 &nbsp;and Quan for comments .
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards<o:p></o:p></p>
<p class=3D"MsoNormal">Shaoyun.liu<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.=
Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;
<br>
<b>Sent:</b> Friday, March 12, 2021 8:55 AM<br>
<b>To:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"msipheader251902e5" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100">[AMD Publ=
ic Use]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">We want to keep ppt_funcs minimal. Adding everything=
 to ppt_funcs and keeping as NULL is not the right way. Please keep the cod=
e to arcturus.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Lijo<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shao=
yun.Liu@amd.com">Shaoyun.Liu@amd.com</a>&gt;
<br>
<b>Sent:</b> Friday, March 12, 2021 7:21 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Thanks for the comments. This light sbr solution cou=
ld be applied to other asic as well. In swsmu code, It will check whether t=
he function pointer set_light_sbr is valid before real call the function. S=
o for other asics if the smu apply
 the same change, just add the ppt function pointer and we will have this s=
upport without further code change.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Shaoyun.liu<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.co=
m">Lijo.Lazar@amd.com</a>&gt;<br>
<b>Sent:</b> March 11, 2021 10:42 PM<br>
<b>To:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.=
Liu@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthroug=
h configuration</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Public Use]<br>
<br>
We don't need this as a generic ppt_func. Reset functionalities are changin=
g over programs and this could be valid only for Arcturus. Please move it t=
o Arcturus swsmu late init.
<br>
<br>
Thanks,<br>
Lijo<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.org">=
amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Behalf Of shaoyunl<br>
Sent: Thursday, March 11, 2021 10:46 PM<br>
To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesk=
top.org</a><br>
Cc: Liu, Shaoyun &lt;<a href=3D"mailto:Shaoyun.Liu@amd.com">Shaoyun.Liu@amd=
.com</a>&gt;<br>
Subject: [PATCH] drm/amdgpu: Enable light SBR in XGMI+passthrough configura=
tion<br>
<br>
This is to fix the commit dda9bbb26c7 where it only enable the light SMU on=
 normal device init. This feature actually need to be enabled after ASIC be=
en reset as well.<br>
<br>
Signed-off-by: shaoyunl &lt;<a href=3D"mailto:shaoyun.liu@amd.com">shaoyun.=
liu@amd.com</a>&gt;<br>
Change-Id: Ie7ee02cd3ccdab3522aad9a02f681963e211ed44<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++----<br>
&nbsp;1 file changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index cada3e77c7d5..fb775a9c0db1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2513,6 +2513,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;enable mgpu fan boost failed (%d).\n&=
quot;, r);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* For XGMI + passthrough configurati=
on , enable light SBR */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_passthrough(adev) &amp;&am=
p; adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.num_=
physical_nodes &gt; 1) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; mutex_lock(&amp;mgpu_info.mutex);<br>
@@ -3615,10 +3618,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_device_cache_pc=
i_state(adev-&gt;pdev))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pci_restore_state(pdev);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Enable lightSBR on SMU in passthro=
ugh + xgmi configuration */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_passthrough(adev) &amp;&am=
p; adev-&gt;gmc.xgmi.num_physical_nodes &gt; 1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; smu_set_light_sbr(&amp;adev-&gt;smu, true);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gmc.xgmi.pend=
ing_reset)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; queue_delayed_work(system_wq, &amp;mgpu_info.delayed_=
reset_work,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; msecs_to_jiffi=
es(AMDGPU_RESUME_MS));<br>
--<br>
2.17.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Clijo.lazar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe4=
884e608e11a82d994e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3d=
8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&=
amp;amp;sdata=3D7ndhtOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;amp;re=
served=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%=
2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04=
%7C01%7Clijo.lazar%40amd.com%7Cc5aedb6c2d9d49d2fee408d8e4b15b5c%7C3dd8961fe=
4884e608e11a82d994e183d%7C0%7C0%7C637510797685776785%7CUnknown%7CTWFpbGZsb3=
d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000=
&amp;amp;sdata=3D7ndhtOVmyZcRMe3UQiGvF%2BprCdBVgo7f6IATXSbQNg4%3D&amp;amp;r=
eserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB3835E9D3AE2F8738D54B4B1BF46F9DM6PR12MB3835namp_--

--===============1642571439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1642571439==--

Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718BFC433DB
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CD164E89
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 17:02:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CD164E89
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F69B6E151;
	Wed, 17 Mar 2021 17:02:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE6806E151
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 17:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpwMljGg/HVQm89Ev417q8LUI2q2RnV/kr5wwO5jAHz5wdZ7zcUeCJnJX3As8CSodwmnsnYm53N4gmXT2F7AaD6VTageY3qyt+Ygf4vstHd98TEP5ucBDeaYA5yYkdVSybbNdQnr9FjEaCpnasboPhwJKykBBGQ1Qi1l5VraL7Jn08yNlzDVw+XWUK7BBWciK+cIhbMWh6LG3UnT37CjXIj/PLkuGx7p/Mwar78BUx+7p/4IDmTc0PLYIuKEdjXOyVzM34+exWDZNVI3KMobqIACScZyNKAfyhr1ufi+Bu+Gap1mflxuwPamRncoBoYqfMCnB4m4HFaVs3LjiorijA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86GYNnkEqs7GXeVXHpmKtICiz1Gd6faozaekMxg8H/A=;
 b=OD15rVcmqp+Hz/e8ttSesu+xsYUaHZQwPnoodnZIgrqdJ+UZW7NymdgWC5gvfHipdxLkcwFqo2gSNeylj1/rKpNwWd3TZzW5E5PvM4GQTZW8pRGrrHyNcoc/lkivnRfplIiU0OiLFudoff2CLFJQqpeK3xrgw82AWx0vsf2DKgza8ZIixA/cByJdonEc6gw+PennkVPlYnQjetYRhWG/B0kZv+jiHmQ5p1LB2J2NJVHZ7Gb2bzuUUd3I0RsHMlSHGobVJOZel2aHSUBrCkU5gtvJwWNzJnu/5lFA6Dmn75KRqAtKELlFG4kUl46omI+Q5XkOeQdF7qqKKVCcZ7E3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86GYNnkEqs7GXeVXHpmKtICiz1Gd6faozaekMxg8H/A=;
 b=zacxaVfYIsRlkzDGHeyLmFHRwdBSxagvL0/CBfMwr0Y9wyTnMoz309p7k8nHXtNqyGKuwaW5U6JHpMXl8Pf6FsmQdECXwQCxRVvLtdnAVz6kH4N8m3y7HC8aa6EDrDNPMe5CbKZJ4wZd455nCl5OCZG2/Yuv8Fa36uuQvB0hZAY=
Received: from MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21)
 by MWHPR1201MB0063.namprd12.prod.outlook.com (2603:10b6:301:4d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 17:02:31 +0000
Received: from MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::d923:bfbc:1230:baa8]) by MW3PR12MB4554.namprd12.prod.outlook.com
 ([fe80::d923:bfbc:1230:baa8%4]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 17:02:31 +0000
From: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, "R, Bindu"
 <Bindu.R@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Topic: [PATCH] drm/amd/display: Allow idle optimization based on vblank.
Thread-Index: AQHXGr8fDLSrm9PcXkqWMnSC9Tl4KKqIDjKAgABZmhI=
Date: Wed, 17 Mar 2021 17:02:31 +0000
Message-ID: <MW3PR12MB4554B23D18EFB926B9EAFF05F96A9@MW3PR12MB4554.namprd12.prod.outlook.com>
References: <20210316234952.254296-1-bindu.r@amd.com>,
 <2a8218f2-9df9-d5c3-3a88-7e930a8c8524@daenzer.net>
In-Reply-To: <2a8218f2-9df9-d5c3-3a88-7e930a8c8524@daenzer.net>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-17T17:02:31.493Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: daenzer.net; dkim=none (message not signed)
 header.d=none;daenzer.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [173.33.192.144]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ce31e8b-7677-40fb-d638-08d8e96673f2
x-ms-traffictypediagnostic: MWHPR1201MB0063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB00635CB3049222B17215EDF3F96A9@MWHPR1201MB0063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:224;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LbwoxJdu/Ucv3SN2FqvPb2TjLupy2472wRVrfG6v8yFquUzi1pe2qNCk7eLemjE7iMECUl+FdDg7NBwqMccd8ifFCcqJvHAIiRYVN7A7y4OpB8xB9UQ3TZqO/vh3FsQo1F2AJG1c5MtRDLYGuwcH7dIvwBgEILF8Oa5IBcWKTtf4AxqcbudBRWr15KsVvBlVmZlvTZJ0hrc+qpTri3lZjwQaE0Xc+B9xAgypBdKpc/ilqFNeLeWz/wrCNJQIbNYavqSXiE7slY6ZODrlfme8Je0VGA5y2dx+cKzWqG11zYDj1emLJ/FvKsbElm1giK0ib5ZrE2jpv8coT2rKGeWq08qo0H6JsLvm2YCd5LRXQkj3eMcaEQ91SeqD42bJ30Wz8lCIGAzjEvhxTZ0LaCVOAKkLNv995yIDL5Q/AwRqmKECgACQErN/TWiG2BG8RFJL1tVaqDFgppMMHM7AJuG+8jUP0HD0Ohz2hbUMRwmEDBzIS1QCD4hrUbusvsOArpdESyyECXkw8dZAhZ/7VYS/eD1qb97pE3ZMVB/SnAjJyIbGr/+5HRp6fVYTsx6YRYjsfrwejPcEU3h76YsS1yNiCoApRFB4kyAuYj9tuT4PZzSzQFA1tSInc+SHkKY/ZObslAEFdkpKbDfZFXDBo7HC/A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4554.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(4326008)(33656002)(8936002)(110136005)(2906002)(55016002)(5660300002)(66946007)(66476007)(9686003)(66556008)(76116006)(83380400001)(316002)(19627405001)(478600001)(86362001)(52536014)(166002)(7696005)(45080400002)(966005)(6506007)(54906003)(53546011)(8676002)(186003)(26005)(64756008)(71200400001)(91956017)(66446008)(66574015);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?8w+zipCawwoGc5GYPWoU6DBd9/h3xOEnbaJ0ume6UoAenTxtULFcVweVJW?=
 =?iso-8859-1?Q?Mu36h7PH4ySa6bF2tO9ipOPPzhUlkBCiOeUN/MEz7mGvZd+nV17Fp/takV?=
 =?iso-8859-1?Q?bdvdDPR4Wlof4osCa5JQGpysi9jsAtVodLscz3Ad9eaP5GHfVSyJwKLpnU?=
 =?iso-8859-1?Q?9B1qM6yvp/u0p8qH+zI59w0zC+pA2LNFg05ZICF9ICSMISkp5v/NiiSqwS?=
 =?iso-8859-1?Q?Arx4POZiwkWJhNFfygTWv6x76uQ1FyNaJASESWIc/VdivjDyKNDf2rWBRN?=
 =?iso-8859-1?Q?+DloXIhVHVDAzqrarNcN/SVaeV/qB0HfB8sSa5VA2x1a3hC5Gjg7UOh4jZ?=
 =?iso-8859-1?Q?qLUYF14q+KzN3T6YRlpMPKTtvgEmHucpfz8ZrtC7m51IqXYeX/hx/lhxHC?=
 =?iso-8859-1?Q?nZng6WeUIpIojAfZ8IhY/OZWd9vaMM00laT9D1aezrSKSg6uiboFEDuqyC?=
 =?iso-8859-1?Q?qIrQ1BHusnL3uNqGzOVXjPvcORLkMxtSswZD6tJY9G3k1xlcSPIaLT3Z+8?=
 =?iso-8859-1?Q?FddkTkJPo9+LMt+RY5YWCmI60f2TrPePADRbHXEcHHB55/Y0prBhFAQ1Sr?=
 =?iso-8859-1?Q?+eFevRI5XVCcjHdPSaG/CkGwSvnuj8rqQFeRlJv1v5Pgpv7mc6QK9FWwSx?=
 =?iso-8859-1?Q?OdV/nfLf5r6fohqxTZFhesvpdqDkjx1ktiaIr8fTVWCHa2PquCRocdj1qd?=
 =?iso-8859-1?Q?g9Ob72A4FzN/U+7AH9qnky0ffdr5bMRyDSKbm/wcxOsBBMC8PpeS4D8J6n?=
 =?iso-8859-1?Q?VaaOpk6ra7TWlgHGY5DnAK/oQX+gUDbzfOJk2gM9ufTuFpJPK2hNj27/H/?=
 =?iso-8859-1?Q?oMerFzVKBGKcpajaHHYIL21pl3HZtfiDeZLMOmVI0e4gAW8t0wNG0lQlS7?=
 =?iso-8859-1?Q?mtezXsWIM61YxU48D6DpErkCA4agAb6UQHeDPSiF28pZpR7xywZDRFskCj?=
 =?iso-8859-1?Q?DTITBSGaIJuIYm3ISQ98Xs4hDCGWTr85IC+NyDwnd8O6hQFBxwd6fNHxFg?=
 =?iso-8859-1?Q?GLYoiGs8XboVtPrbJbApvU6gpiszf7IWXQdLhe64wIxvZR1RKFpt6BR9SL?=
 =?iso-8859-1?Q?IeBYEQW+KeIF4+i6fpRDzsjV/XXcoilJJESQb0xqZp2aipJ6EMoqrxLyxV?=
 =?iso-8859-1?Q?P8zvsLTCZ2CY19Po8XtUksgf2MX+4CggSFiYlWFOK9paJl+RbYWX+HW7WZ?=
 =?iso-8859-1?Q?NBVfNUW7ao0jsyzUT+VToRg9SNGD2lfyYOAN693r0SqMlp+qfINzNRyFa+?=
 =?iso-8859-1?Q?zdTI6UhEJuhE2JGsoIqx8Jm5PdbyQ3XpPqADO+ELZVnfwDX1s8WdK32ryG?=
 =?iso-8859-1?Q?b4h/+wYO/z4lHs+sD4bUaoISMWI4juijTRo+OYvdANHPU8IYGYaYYG9q6J?=
 =?iso-8859-1?Q?LRXpKew2pD?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4554.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce31e8b-7677-40fb-d638-08d8e96673f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 17:02:31.2751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LwRbzb6/HuoJrqaz+y0OeIQDsplSgMo86k8KIfqqizf5bp1EKi03pK5QkloCB0tg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou1,
 Tao" <Tao.Zhou1@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Content-Type: multipart/mixed; boundary="===============1513598430=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1513598430==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_MW3PR12MB4554B23D18EFB926B9EAFF05F96A9MW3PR12MB4554namp_"

--_000_MW3PR12MB4554B23D18EFB926B9EAFF05F96A9MW3PR12MB4554namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Hi Bindu,

dc_allow_idle_optimizations() should be called within mutex_lock(&dm->dc_lo=
ck). Please call it right after WARN_ON(!dc_commit_state(dm->dc, dc_state))=
 but before unlock().

Bhawan
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Michel D=
=E4nzer <michel@daenzer.net>
Sent: March 17, 2021 7:37 AM
To: R, Bindu <Bindu.R@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@list=
s.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Lakha, Bhawanpreet <Bhawanpr=
eet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amd/display: Allow idle optimization based on vbla=
nk.

On 2021-03-17 12:49 a.m., Bindu Ramamurthy wrote:
> [Why]
> idle optimization was being disabled after commit.
>
> [How]
> check vblank count for display off and enable idle optimization based on =
this count.
>
> Signed-off-by: Bindu Ramamurthy <bindu.r@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 553e39f9538c..56a55143ad2d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -987,7 +987,7 @@ static void event_mall_stutter(struct work_struct *wo=
rk)
>
>        if (vblank_work->enable)
>                dm->active_vblank_irq_count++;
> -     else
> +     else if(dm->active_vblank_irq_count)
>                dm->active_vblank_irq_count--;

The commit log should explain why this part is needed.


--
Earthling Michel D=E4nzer               |               https://nam11.safel=
inks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;data=3D0=
4%7C01%7Cbhawanpreet.lakha%40amd.com%7C11fd0779679742148e2a08d8e938fe34%7C3=
dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515778296313590%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C1000&amp;sdata=3D%2BPsyjDxRCTdR9HL1QSlCraWo7YpFg%2FJT8i%2BSsG%2BQvZE%3D=
&amp;reserved=3D0
Libre software enthusiast             |             Mesa and X developer
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cbhawanpr=
eet.lakha%40amd.com%7C11fd0779679742148e2a08d8e938fe34%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637515778296313590%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3DL4fr6qPeO5rcMi0zg9bk9xLRTKtyVRTJ3LcSPd3Qlyw%3D&amp;reserved=3D0

--_000_MW3PR12MB4554B23D18EFB926B9EAFF05F96A9MW3PR12MB4554namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Bindu,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
<font size=3D"2"><span style=3D"font-size:11pt">dc_allow_idle_optimizations=
() should be called within mutex_lock(&amp;dm-&gt;dc_lock). Please call it =
right after
<font size=3D"2"><span style=3D"font-size:11pt">WARN_ON(!dc_commit_state(dm=
-&gt;dc, dc_state)) but before unlock().</span></font></span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><font size=3D"2"><span styl=
e=3D"font-size:11pt"><br>
</span></font></span></font></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<font size=3D"2"><span style=3D"font-size:11pt"><font size=3D"2"><span styl=
e=3D"font-size:11pt">Bhawan</span></font></span></font><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Michel D=E4nzer &lt;michel@da=
enzer.net&gt;<br>
<b>Sent:</b> March 17, 2021 7:37 AM<br>
<b>To:</b> R, Bindu &lt;Bindu.R@amd.com&gt;; amd-gfx@lists.freedesktop.org =
&lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Feng, Kenn=
eth &lt;Kenneth.Feng@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Lak=
ha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd/display: Allow idle optimization based =
on vblank.</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2021-03-17 12:49 a.m., Bindu Ramamurthy wrote:<=
br>
&gt; [Why]<br>
&gt; idle optimization was being disabled after commit.<br>
&gt; <br>
&gt; [How]<br>
&gt; check vblank count for display off and enable idle optimization based =
on this count.<br>
&gt; <br>
&gt; Signed-off-by: Bindu Ramamurthy &lt;bindu.r@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--<br=
>
&gt;&nbsp; 1 file changed, 5 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drive=
rs/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; index 553e39f9538c..56a55143ad2d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c<br>
&gt; @@ -987,7 +987,7 @@ static void event_mall_stutter(struct work_struct =
*work)<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (vblank_work-&gt;enable)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dm-&gt;active_vblank_irq_count++;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; else if(dm-&gt;active_vblank_irq_count)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dm-&gt;active_vblank_irq_count--;<br>
<br>
The commit log should explain why this part is needed.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://nam11.safe=
links.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.com%2F&amp;amp;dat=
a=3D04%7C01%7Cbhawanpreet.lakha%40amd.com%7C11fd0779679742148e2a08d8e938fe3=
4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515778296313590%7CUnknown=
%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6=
Mn0%3D%7C1000&amp;amp;sdata=3D%2BPsyjDxRCTdR9HL1QSlCraWo7YpFg%2FJT8i%2BSsG%=
2BQvZE%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fredhat.=
com%2F&amp;amp;data=3D04%7C01%7Cbhawanpreet.lakha%40amd.com%7C11fd077967974=
2148e2a08d8e938fe34%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375157782=
96313590%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTi=
I6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3D%2BPsyjDxRCTdR9HL1QSlCraWo7=
YpFg%2FJT8i%2BSsG%2BQvZE%3D&amp;amp;reserved=3D0</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; Mesa and X developer<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%=
7C01%7Cbhawanpreet.lakha%40amd.com%7C11fd0779679742148e2a08d8e938fe34%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515778296313590%7CUnknown%7CTWFp=
bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%=
7C1000&amp;amp;sdata=3DL4fr6qPeO5rcMi0zg9bk9xLRTKtyVRTJ3LcSPd3Qlyw%3D&amp;a=
mp;reserved=3D0">https://nam11.safelinks.protection.outlook.com/?url=3Dhttp=
s%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=
=3D04%7C01%7Cbhawanpreet.lakha%40amd.com%7C11fd0779679742148e2a08d8e938fe34=
%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637515778296313590%7CUnknown%=
7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M=
n0%3D%7C1000&amp;amp;sdata=3DL4fr6qPeO5rcMi0zg9bk9xLRTKtyVRTJ3LcSPd3Qlyw%3D=
&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MW3PR12MB4554B23D18EFB926B9EAFF05F96A9MW3PR12MB4554namp_--

--===============1513598430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1513598430==--

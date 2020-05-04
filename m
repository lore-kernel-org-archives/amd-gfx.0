Return-Path: <SRS0=L96E=6S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF52C3A5A9
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2020 14:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0205F206B9
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2020 14:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2gWSO94V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0205F206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADEF489D57;
	Mon,  4 May 2020 14:56:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5F089D57
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2020 14:56:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqC4BHHegeqwI3PKZFx468g6lySuycGjauLVaOf6+KNsJYHxHmz+rbPehGWJshka29pDiN9eR862MUqMVJUTTDGKYOLvXqzKzyJH1iw6slFQVbh7B/0ciOyaQSj5x9sbKUjaud8WWvxBJVgbE0t1hiQG1OSuPPZAyGZ7Op2xft17egbppD4HpVsJDi3ViMCzYLubf3REs9daAy9ss8yTjqLzGAdhOJcf5deYZQIcllkynTpq0p722iFc1PTiqoR5KRQj7DLLV/MqwLXp/Xub+4UHTQfjpq8FnHzzqW4Fq3STHLBAuC1R9k6R/BFpwYbeRq2Qf1r360uNF74LUsleDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oht9YhUoWtmphL0aCgPJj66gdZHauDF/qtuQizu4Ksk=;
 b=Pg0KSuatW+l0NIjsSa3lruTkNE/LipayjhW94Xm/7X2TDK9WQRVzdAoikhPsPsItjT/4XppzzKkFu5ZPOQ11W6E0AyZYdfwSs6z8nN5pf6yD0Og/7SIuIj0/dYVege6F5AHmQMqqjqN07ko1e9yqbrSZHbh3LLuWonL381Bjjydqqhb3AtHzBxQWtnZcEHOMkL2YGOM3rYYeWtN9qKsopJRnarNlqloQl7nyIsa8tDwUM5sTwDxfVbA1MDMGnMBJk1kMC0gSJWl+kWXVgoI+UUQMARJwHXfJjkOl3QgSMFyqFrMVaulX/ySGO16bQ7xrtXU2OH5el7UjbvxzHI1KPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oht9YhUoWtmphL0aCgPJj66gdZHauDF/qtuQizu4Ksk=;
 b=2gWSO94V07cxyv96/TXR2T8ncYjalFm/jaf4JL1AMCt2MZnktUi1bGlDmmraEI2nEu3Wdzo/Y3f7tnHK/YMxPzi2vFuf5HRNTobGDvJaFQe6nZnxtDiaMmc9EkMq/oNeIuCbNx1bagjsjv/mKqihWW83PFcstA6gCEFDxXha48Q=
Received: from BN6PR1201MB2466.namprd12.prod.outlook.com
 (2603:10b6:404:b0::20) by BN6PR1201MB2480.namprd12.prod.outlook.com
 (2603:10b6:404:b0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Mon, 4 May
 2020 14:56:18 +0000
Received: from BN6PR1201MB2466.namprd12.prod.outlook.com
 ([fe80::dd9a:57b3:84e7:15d9]) by BN6PR1201MB2466.namprd12.prod.outlook.com
 ([fe80::dd9a:57b3:84e7:15d9%8]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 14:56:18 +0000
From: "Zuo, Jerry" <Jerry.Zuo@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wu, Hersen"
 <hersenxs.wu@amd.com>, "S, Shirish" <Shirish.S@amd.com>
Subject: Re: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance
 edid corruption test
Thread-Topic: [PATCH] drm/amd/display: Add dm support for DP 1.4 Compliance
 edid corruption test
Thread-Index: AQHWHk/fctx7EE5CRUqNRCrxPp5aCaiTSOkAgAS+2NI=
Date: Mon, 4 May 2020 14:56:18 +0000
Message-ID: <BN6PR1201MB24668EEBE00D4F26CA410CF1E5A60@BN6PR1201MB2466.namprd12.prod.outlook.com>
References: <20200429175857.17051-1-Jerry.Zuo@amd.com>,
 <894f6404-3a12-0592-1f61-133c32ee3607@amd.com>
In-Reply-To: <894f6404-3a12-0592-1f61-133c32ee3607@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-CA
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-05-04T14:56:18.028Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d75ec20a-7b29-45d0-5cbd-08d7f03b4d6b
x-ms-traffictypediagnostic: BN6PR1201MB2480:|BN6PR1201MB2480:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR1201MB2480071EF71DC32EBDCB5D16E5A60@BN6PR1201MB2480.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /rRryW7iZFnTfpJkBoNWPIhT3EOsDrOmQOyBHwXJ0ROKvLTBO0HZ5a6g/FQbJNSH0lnNuZLYIaZjefAq4FoCSNlDLRT6waLMjJ2r3XUh5kWXRzfA7SORlgLWJz6qpCZlUHmYkjoI0oaXi0deDoLO1FvU6bq0T4GduM9PEHxx8OCr496tNjMN4ICTEM8fJS1dDUKT1V49fC0lbJtwPfIAyHnMFS9udlmRG93BO4jQ7zm5mlFYvF6jjAmShDv8munA0iZ424dKl2nAZIGWPXvpNvyQB+7YPKKwahhzuKlA8OHtKeWc4JIlcEwgrUMHz2E6ifisT6N8TzY7C5t3QXqIJX8ihRHJQfXIYYv43kyKRb0wTs1TItCHmo2zmCijShy4LB07b5pb+dp6Odlj8tGf/0BdX3Rot5wHOqufnlFd5wSabr/1pdDYv02R+TeTEoKe
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR1201MB2466.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(4326008)(6636002)(9686003)(5660300002)(186003)(478600001)(86362001)(2906002)(55016002)(33656002)(53546011)(64756008)(66556008)(7696005)(6506007)(8676002)(26005)(91956017)(110136005)(316002)(54906003)(76116006)(52536014)(66476007)(71200400001)(8936002)(66946007)(66446008)(19627405001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: HseF1Et6OK4YlN+I5uNA4t7ZYNICjfkVpXBVvNBnJPdt+RctwDt735/IPzSdFe4ry6gW3035kSXzJOm7h5oSNItcizYBr0g0zAd76K+qunv7G/mKSGbojXnZUKwFxmn4bsuFu0ESCbD8/LGRJ5HXStqtESOUlWCkdCfOfg5haLGTvG11iiU+TfB4Sp3TdJouX0OS6reWvrniZJ6DqfqtJfvaGz/Q4XNGToPH36yMC/r5w172cUhzYLZaixzxJef/yyCfe/TBc078zGRK9KxUTp7CpFJ1TButpsAfiCiRdumL14HdXLtPDQCDjLK0CTELSyUczx6BHNxv8xvVosgOyPtuqTJYMx6NaqhQDNUp04JhM99sN8kRU5zbJE8b5lbTgFTg5gonlsIyqDKsZ95dW2MSbDap08fvNljMDZXmbVmB3LMkEuwY7e2g5sH3QX2psmH3LRrdyT/zttOK0xwtu9Z+ESXS94oAaqq+tEO1/tUCB99v+1eXHCXPLNJPn/CjVlfkTQUbX3GqdykrsKmG7qHXgcd60CC9K9+BmQAHUCKdCrWlyzX0svdLtHXIaru0fKgcfogkZ1akxSvRUH0vtHdMVTwy/jahT4/ANrH9A67m95XCkdPaILs8K45b3JBDEnA2ro2LysV5wAUP7lvuBIyr93HFkYmhrOvC2L6x08wqmIw6gDZUs5IRUKiP9CAxkZEPjRz3O9xaA6Rxq4atAtmVqEBOjSEEgtr4RXiEuwPKkbZk5wyFSpVNBAQBghNAR1z7uA3Q4YNTptWJldMRuVNKm5Soh7Xpf/XsK9mpZF0=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75ec20a-7b29-45d0-5cbd-08d7f03b4d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 14:56:18.6943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sj2IRlwNF+YHe3Mg+9fgta795p1Vk1d8Wg+qCjEcg7kEYkUSZ3Z55QSinrr1Efas
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2480
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>
Content-Type: multipart/mixed; boundary="===============1509867236=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1509867236==
Content-Language: en-CA
Content-Type: multipart/alternative;
	boundary="_000_BN6PR1201MB24668EEBE00D4F26CA410CF1E5A60BN6PR1201MB2466_"

--_000_BN6PR1201MB24668EEBE00D4F26CA410CF1E5A60BN6PR1201MB2466_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

On 2020-04-29 1:58 p.m., Jerry (Fangzhi) Zuo wrote:
> It works together with drm framework
> "drm: Add support for DP 1.4 Compliance edid corruption test"
>
> Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 40 ++++++-------------
>  1 file changed, 13 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index c407f06cd1f5..b086d5c906e0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -554,6 +554,7 @@ enum dc_edid_status dm_helpers_read_local_edid(
>                struct dc_sink *sink)
>  {
>        struct amdgpu_dm_connector *aconnector =3D link->priv;
> +     struct drm_connector *connector =3D &aconnector->base;
>        struct i2c_adapter *ddc;
>        int retry =3D 3;
>        enum dc_edid_status edid_status;
> @@ -571,6 +572,15 @@ enum dc_edid_status dm_helpers_read_local_edid(
>
>                edid =3D drm_get_edid(&aconnector->base, ddc);
>
> +             /* DP Compliance Test 4.2.2.6 */
> +             if (link->aux_mode && connector->edid_corrupt)
> +                     drm_dp_send_real_edid_checksum(&aconnector->dm_dp_a=
ux.aux, connector->real_edid_checksum);
> +
> +             if (!edid && connector->edid_corrupt) {
> +                     connector->edid_corrupt =3D false;
> +                     return EDID_BAD_CHECKSUM;

You return EDID_BAD_CHECKSUM here but the surrounding loop uses
"edid_status =3D=3D EDID_BAD_CHECKSUM" as condition to go again. Is this
duplicating functionality that dm_helpers_parse_edid_caps did?

Harry


It is not duplicate. You mentioned dm_helpers_parse_edid_caps() with retrie=
s is fallen into the 3rd checkup step below:
1. If base block is fetched with checksum mismatch, drm will set connector-=
>edid_corrupt and return with Null edid buffer. This case will be handled a=
s compliance test case 4.2.2.6, retuning EDID_BAD_CHECKSUM right away witho=
ut going ahead to parse edid caps --> newly added
2. If edid buffer cannot be created, return EDID_NO_RESPONSE but do not set=
 connector->edid_corrupt
3. For invalid extension blocks, drm doesn't set connector->edid_corrupt. T=
his case will be further handled by dm_helpers_parse_edid_caps() with 3 tim=
es retries.
If failed any step above with EDID_BAD_CHECKSUM, will enable fail-safe mode=
 in DC.

Jerry


> +             }
> +
>                if (!edid)
>                        return EDID_NO_RESPONSE;
>
> @@ -605,34 +615,10 @@ enum dc_edid_status dm_helpers_read_local_edid(
>                DRM_ERROR("EDID err: %d, on connector: %s",
>                                edid_status,
>                                aconnector->base.name);
> -     if (link->aux_mode) {
> -             union test_request test_request =3D { {0} };
> -             union test_response test_response =3D { {0} };
> -
> -             dm_helpers_dp_read_dpcd(ctx,
> -                                     link,
> -                                     DP_TEST_REQUEST,
> -                                     &test_request.raw,
> -                                     sizeof(union test_request));
> -
> -             if (!test_request.bits.EDID_READ)
> -                     return edid_status;
>
> -             test_response.bits.EDID_CHECKSUM_WRITE =3D 1;
> -
> -             dm_helpers_dp_write_dpcd(ctx,
> -                                     link,
> -                                     DP_TEST_EDID_CHECKSUM,
> -                                     &sink->dc_edid.raw_edid[sink->dc_ed=
id.length-1],
> -                                     1);
> -
> -             dm_helpers_dp_write_dpcd(ctx,
> -                                     link,
> -                                     DP_TEST_RESPONSE,
> -                                     &test_response.raw,
> -                                     sizeof(test_response));
> -
> -     }
> +     /* DP Compliance Test 4.2.2.3 */
> +     if (link->aux_mode)
> +             drm_dp_send_real_edid_checksum(&aconnector->dm_dp_aux.aux, =
sink->dc_edid.raw_edid[sink->dc_edid.length-1]);
>
>        return edid_status;
>  }
>

--_000_BN6PR1201MB24668EEBE00D4F26CA410CF1E5A60BN6PR1201MB2466_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(0, 0, 0); font-family: Calibri,Arial,Helvetica,san=
s-serif; font-size: 12pt;">
<font size=3D"2"><span style=3D"font-size: 11pt;">On 2020-04-29 1:58 p.m., =
Jerry (Fangzhi) Zuo wrote:<br>
&gt; It works together with drm framework<br>
&gt; &quot;drm: Add support for DP 1.4 Compliance edid corruption test&quot=
;<br>
&gt; <br>
&gt; Signed-off-by: Jerry (Fangzhi) Zuo &lt;Jerry.Zuo@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 40 &#43;&#43;&#4=
3;&#43;&#43;&#43;-------------<br>
&gt;&nbsp; 1 file changed, 13 insertions(&#43;), 27 deletions(-)<br>
&gt; <br>
&gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c=
 b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt; index c407f06cd1f5..b086d5c906e0 100644<br>
&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_help=
ers.c<br>
&gt; @@ -554,6 &#43;554,7 @@ enum dc_edid_status dm_helpers_read_local_edid=
(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct dc_sink *sink)<br>
&gt;&nbsp; {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dm_connector *=
aconnector =3D link-&gt;priv;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_connector *connector =3D &amp=
;aconnector-&gt;base;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct i2c_adapter *ddc;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int retry =3D 3;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum dc_edid_status edid_sta=
tus;<br>
&gt; @@ -571,6 &#43;572,15 @@ enum dc_edid_status dm_helpers_read_local_edi=
d(<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; edid =3D drm_get_edid(&amp;aconnector-&gt;base, ddc);<b=
r>
&gt;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* DP Compliance Test 4.2.2.6 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (link-&gt;aux_mode &amp;&amp; connector-&gt;edid_corrupt)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_dp_send_real_ed=
id_checksum(&amp;aconnector-&gt;dm_dp_aux.aux, connector-&gt;real_edid_chec=
ksum);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!edid &amp;&amp; connector-&gt;edid_corrupt) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; connector-&gt;edid_=
corrupt =3D false;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return EDID_BAD_CHE=
CKSUM;<br>
<br>
You return EDID_BAD_CHECKSUM here but the surrounding loop uses<br>
&quot;edid_status =3D=3D EDID_BAD_CHECKSUM&quot; as condition to go again. =
Is this<br>
duplicating functionality that dm_helpers_parse_edid_caps did?<br>
<br>
Harry</span></font></div>
<div><br>
</div>
<div><br>
</div>
<div><font color=3D"#000000" face=3D"Calibri">It is not duplicate. You ment=
ioned <font color=3D"#000000" face=3D"Calibri">
dm_helpers_parse_edid_caps() with retries is fallen into the 3rd checkup st=
ep&nbsp;below</font>:<font color=3D"#000000" face=3D"Calibri"><br>
1. If base block is fetched with checksum mismatch, drm will set connector-=
&gt;edid_corrupt and return with Null edid buffer. This case will be handle=
d as compliance test case 4.2.2.6, retuning EDID_BAD_CHECKSUM right away wi=
thout going ahead to parse edid caps
 --&gt; newly added<font color=3D"#000000" face=3D"Calibri"><br>
2. If edid buffer cannot be created, return EDID_NO_RESPONSE but do not set=
 connector-&gt;edid_corrupt<font color=3D"#000000" face=3D"Calibri"><br>
3. For invalid extension blocks, drm doesn't set connector-&gt;edid_corrupt=
. This case will be further handled by dm_helpers_parse_edid_caps() with 3 =
times retries.
<font color=3D"#000000" face=3D"Calibri"><br>
</font></font></font></font></font></div>
<div><font color=3D"#000000" face=3D"Calibri">If failed any step above with=
 EDID_BAD_CHECKSUM, will&nbsp;enable fail-safe mode in DC.</font></div>
<div><br>
</div>
<div><font color=3D"#000000" face=3D"Calibri">Jerry</font></div>
<div><font color=3D"#000000" face=3D"Calibri"><font size=3D"2"><span style=
=3D"font-size: 11pt;"><br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!edid)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
EDID_NO_RESPONSE;<br>
&gt;&nbsp; <br>
&gt; @@ -605,34 &#43;615,10 @@ enum dc_edid_status dm_helpers_read_local_ed=
id(<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;EDID err: %d, on connector: %s&quot;,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; edid_status,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; aconnector-&gt;base.name);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;aux_mode) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; union test_request test_request =3D { {0} };<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; union test_response test_response =3D { {0} };<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dm_helpers_dp_read_dpcd(ctx,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; li=
nk,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DP=
_TEST_REQUEST,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;test_request.raw,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(union test_request));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!test_request.bits.EDID_READ)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return edid_status;<br>
&gt;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; test_response.bits.EDID_CHECKSUM_WRITE =3D 1;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dm_helpers_dp_write_dpcd(ctx,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; li=
nk,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DP=
_TEST_EDID_CHECKSUM,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;sink-&gt;dc_edid.raw_edid[sink-&gt;dc_edid.length-1],<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1)=
;<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dm_helpers_dp_write_dpcd(ctx,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; li=
nk,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DP=
_TEST_RESPONSE,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &a=
mp;test_response.raw,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; si=
zeof(test_response));<br>
&gt; -<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* DP Compliance Test 4.2.2.3 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (link-&gt;aux_mode)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; drm_dp_send_real_edid_checksum(&amp;aconnector-&gt;dm_dp_aux.aux, s=
ink-&gt;dc_edid.raw_edid[sink-&gt;dc_edid.length-1]);<br>
&gt;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return edid_status;<br>
&gt;&nbsp; }<br>
&gt; <br>
</span></font></font></div>
</div>
</body>
</html>

--_000_BN6PR1201MB24668EEBE00D4F26CA410CF1E5A60BN6PR1201MB2466_--

--===============1509867236==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1509867236==--

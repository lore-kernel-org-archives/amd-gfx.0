Return-Path: <SRS0=F65H=PB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE44C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 17:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48AEB61152
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Oct 2021 17:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 48AEB61152
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76DF6E092;
	Wed, 13 Oct 2021 17:06:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75E926E092
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Oct 2021 17:06:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Up4NJWduwQm+sVOxFRs0868eGilynSBxZV8c5eAcwZR7hVUfQPDqqurcIpvDlQzeFz08S4iNiqJcfedKyTzKvRFBEBDFbOooBA3CYdsqzZQ4HyEPVmqdjjE8U1GHqWXLhW/n2S/LisN/inywDa84ngUAmUeO4/UedfXkZfYkzu6wwpghmyCbqGmtra7ZCXwjHq7iR+uBIezAzWAgGam8LTLQzWudebBGJMmzmanKsy3HSEbK0+m7v/maYb7m8d1O/4rw+PGz2KqeXebUltgCVbGzCXyfycfv9Q5MWOTNBdt/O+xTOSjLZdhu2gZR8n53RbcOwaOPxsKnnUM/4qQ9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRFcAVJOZpS1AkDVY21UsaatP1prHWVbCoF7L9WMsxQ=;
 b=hPzAesE7IdXHZSCkRMY9kh5TFkYBzT3Sg/USyFCQxU6R2dS3qJOGxb8W2fauAjn+58SiZFUeD0P6pn4ax/Z2hgG3nff5/XNupP8nLgFTIduBWIdu9yOk+U1QxfOC1014inTM+9Y7ik542855UQ7tiF46pAN221xx9JsQ2tauO94I/YsiZIyaq/C6Xg1KwrWQHYQyrxE/1d+o/lL3M+fpoQsCXDds7l/5ad+Jt6nXYKW/41vacH5cXvgQ1IQhpGMZCpqxfpyDrlaaxv2Xek/d2WaWRKIUc8fK1iSV0tGC3Xmbjczl/lLevDP8JIRLi6U+u3gXGsDBhpn+9VLfU5qnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRFcAVJOZpS1AkDVY21UsaatP1prHWVbCoF7L9WMsxQ=;
 b=lH0auzqV/KngOYRxZ7aHtMRs9PQ2u6N3yO7YiamTTo2gsTZ1hI700eIlboowkLkXUiwQvf/w94qWlAzyal4/F2muTTKbWjd6xNKxMwcyhVXtHn9DAPlpfLJ3vcE4SuG7KuSwHd/btnUhJ5gO1RbeBkjmdFg4t4bTOxuRDZQLXEs=
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR1201MB2490.namprd12.prod.outlook.com (2603:10b6:3:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 17:06:43 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 17:06:43 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
Thread-Topic: [PATCH 0/5] 0 MHz is not a valid current frequency
Thread-Index: AQHXv9/4/EpvcdJUuESgrPNHcc7xKavQUc0AgADLY4CAAAurVw==
Date: Wed, 13 Oct 2021 17:06:43 +0000
Message-ID: <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
 <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
In-Reply-To: <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-13T17:03:54.0669666Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9a4ae65-6ae7-4696-ea3a-08d98e6bd4f6
x-ms-traffictypediagnostic: DM5PR1201MB2490:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB2490AB5AAE57DA77E213619D97B79@DM5PR1201MB2490.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpQdCS6CZt9Tqez+3qfGeDsFpyBGZI5/4iqLNcldFU+CrNhugvqSZplL657SQTEnsL4STCDmf++I35vbo20c0HxCqj9LHthI8qXJkFiOIBAAnCFZDPm545p+4AaGDIaTnP3t5Vw1FBcm2ANEj+mKeweQsnCYx0tm3ken/esjA70mOLODIh28s1SDAz6SKX3gTZbg9iKZBcsUUWZ2cXK7HH6gqkl5CgJPV5Ph3wpi419MSZoPhFvV/eTp2xMTV1L7Qa0F8jLqmgeeL1ExJjAXnPBXe7ypP05zkyRRmRdR++zog1ftyxS7Prg18Y9BJnS84gevBe6BuYIlNEZytUMgP8z9XtH0y3Tdlsx/ijJL3Zlt83Lf3G0aQLzI6hCubeAEgw5tY72rjZRLcC8CTqem8+1cPUIKtETVVjZ9E6oTH7s8BtAifQA3Mdj7T1BbEybjcYrQPQwa8wvytxi08jA8P8l+zxVE2FNWPQLShupNtJ/mPUmDuCftbZq8EzsAcI4P3DUhg1VJQdVkd2XeOAYNGKG1LX/Osh3/zVmGg45hx70JNUMh0k9M/vDJfcHRDK18yy/WE8GCH49xXHfPF4Sr/5Xf6pufwltEqJf5mDSGILBw6CSHoQWla7ThNJlcuEJSJ6JPnleW+ikD8/53Mig1ozOwEbMYBWJZfnD8ENQoTXEQgi572gtFO6/kdPu9yLgDh7prc7HqvjVWS0In3dn2sg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(8676002)(4326008)(6506007)(316002)(53546011)(26005)(2906002)(110136005)(86362001)(76116006)(38070700005)(33656002)(66556008)(66446008)(66946007)(7696005)(9686003)(38100700002)(66476007)(64756008)(55016002)(5660300002)(4001150100001)(508600001)(91956017)(52536014)(83380400001)(8936002)(122000001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K+Am+J6JBNE/g/1J69QaagnO1rEZjwWYO+gIosETNWV6YiA54KCu2MCqtCmO?=
 =?us-ascii?Q?xyqOsLglUEYmxuRRUEhXNC0NjZeyM5qINfY1LjwhQ+eu4j01y3PadGVJNCI0?=
 =?us-ascii?Q?1X7d/h8QMihHZxqWoIHsNG2Ov1NaFPp1a2a9Nup0VMkKZ9lLUja2fOc5XsWQ?=
 =?us-ascii?Q?yzSoDHKeGZjh4klhbl7Ds5pNDS+uUTgyWdGKpO4RtGczyTa8wPCsxHy9Unmh?=
 =?us-ascii?Q?woAMWKXZWTQb+H69Tix+29mXvv6JiwfL2MnbOOsCUhY7jGa1nx2z7Z+F/mvh?=
 =?us-ascii?Q?la67cI07YWyJmXb58UWl47ww9fmaAuRRvSuPUf+okd2V92qrxNOwE2unacMc?=
 =?us-ascii?Q?nvz7YjZgxWtEuaNp9z2jmfHVRedEyAe4SOxtw1ah2s3SASFyL1+7txPNAJOH?=
 =?us-ascii?Q?chHdftvt9qHh19057LjTU+EPrbiqQbAgdwkTXOACfEi5e2c4WmPlGhOzeXhv?=
 =?us-ascii?Q?pOjxGqZZbrUHL8W138cMvYq20B9oDHCT62nT6GHDZTeVAbxcusgNuDUxf58K?=
 =?us-ascii?Q?/n9vJ/KA9+vYkPgICeB4Vx+fdK4CEbtWXxxmkoB4WdYMge3QSaGkzxXi8gI4?=
 =?us-ascii?Q?XTPBTUuIp7EhwRh7840nIxPrcaQ/WAOyGVzt9N/VrqTQap1y+D35Su0giRFl?=
 =?us-ascii?Q?l6BfM7fba81lsojr0o2OBLfqoltAUbI3gK67fNYPNb+dyatqM8d+IYUuQFuN?=
 =?us-ascii?Q?oSW8jEaOYaL5+l6HZ/ZYmaaKumdmVz1HFE5g4GdsVvPmiiYfH3nL+BSwy5YW?=
 =?us-ascii?Q?vk3Xlt4VeeTTaqqc8/wZkYntGUJAVu/vAFfzQknNCF9GBr/7+rIhzRDXEt8t?=
 =?us-ascii?Q?WMDhKZlJnjjZmCtQQA13YYZjEeimeO5vHfrQJBcidCZRAA9WhenpIgLJvkQW?=
 =?us-ascii?Q?bIEwct/4C54s6ZT53OZZJv9efqW6EBnqpovGr0Lf9B+dtHijX8ACV8laJ00A?=
 =?us-ascii?Q?uCqL3dctdWEx9pU+QvWwHnu2aqcoUOfDvhlTk4ggL3DJza2/VULzj4n2zII6?=
 =?us-ascii?Q?oAJglRh5YrI+ze29oZVvrp+CjUFld/CXdbFMYty5DH7Nb2Fl5R6tgiO0OQV6?=
 =?us-ascii?Q?hhpKwxJ6WGNFnylSH4r8p7m/lWS9M9Z0eGDfiBE1f6FaSFRfxVzHSL0TVWH1?=
 =?us-ascii?Q?pK5+TTmXR1Nb656b0oz+GSyxXS5GPCax8ftkYY/X/V/E5bQ8UTDIaIVDsrGo?=
 =?us-ascii?Q?8qtbJj+lUsBG2YWOlLXYLHjeB3/LDniWJgVLMyLd6KK1KQMAn32doM2LVEKZ?=
 =?us-ascii?Q?NpsHTaN87muwcCS0eCIMEy35byt8+hKXh8auSpm1Ewh1xcaMJxSrSTFyKpSO?=
 =?us-ascii?Q?cmuCPCNqwfg6PM4gr70SjLfZk9rYffdKgyTYS7/g6ql5YA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB39307EA02DE72479774D8FF297B79DM6PR12MB3930namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a4ae65-6ae7-4696-ea3a-08d98e6bd4f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2021 17:06:43.4922 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFzj6yK00scZ+kJg4YTnSx4aecTmYcWXAKS2Sxd+nvIaNZZt/42EE2vjGxIP9D7u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2490
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB39307EA02DE72479774D8FF297B79DM6PR12MB3930namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

>Or maybe just a list without default hint, i.e. no asterisk?

I think this is also fine meaning we are having trouble in determining the =
current frequency or DPM level. Evan/Alex? Don't know if this will crash th=
e tools.

Thanks,
Lijo
________________________________
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Wednesday, October 13, 2021 9:52:09 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency

On 2021-10-13 00:14, Lazar, Lijo wrote:
>
> On 10/13/2021 8:40 AM, Luben Tuikov wrote:
>> Some ASIC support low-power functionality for the whole ASIC or just
>> an IP block. When in such low-power mode, some sysfs interfaces would
>> report a frequency of 0, e.g.,
>>
>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>> 0: 500Mhz
>> 1: 0Mhz *
>> 2: 2200Mhz
>> $_
>>
>> An operating frequency of 0 MHz doesn't make sense, and this interface
>> is designed to report only operating clock frequencies, i.e. non-zero,
>> and possibly the current one.
>>
>> When in this low-power state, round to the smallest
>> operating frequency, for this interface, as follows,
>>
> Would rather avoid this -
>
> 1) It is manipulating FW reported value. If at all there is an uncaught
> issue in FW reporting of frequency values, that is masked here.
> 2) Otherwise, if 0MHz is described as GFX power gated case, this
> provides a convenient interface to check if GFX is power gated.
>
> If seeing a '0' is not pleasing, consider changing to something like
>        "NA" - not available (frequency cannot be fetched at the moment).

There's a ROCm tool which literally asserts if the values are not ordered i=
n increasing order. Now since 0 < 550, but 0 is listed as the second entry,=
 the tool simply asserts and crashes.

It is not clear what you'd rather see here:

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 550Mhz
1: N/A *
2: 2200MHz
$_

Is this what you want to see? (That'll crash other tools which expect %uMhz=
.)

Or maybe just a list without default hint, i.e. no asterisk?

$cat /sys/class/drm/card0/device/pp_dpm_sclk
0: 550Mhz
1: 2200MHz
$_

What should the output be?

We want to avoid showing 0, but still show numbers.

Regards,
Luben

>
> Thanks,
> Lijo
>
>> $cat /sys/class/drm/card0/device/pp_dpm_sclk
>> 0: 500Mhz *
>> 1: 2200Mhz
>> $_
>>
>> Luben Tuikov (5):
>>    drm/amd/pm: Slight function rename
>>    drm/amd/pm: Rename cur_value to curr_value
>>    drm/amd/pm: Rename freq_values --> freq_value
>>    dpm/amd/pm: Sienna: 0 MHz is not a current clock frequency
>>    dpm/amd/pm: Navi10: 0 MHz is not a current clock frequency
>>
>>   .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 60 +++++++++------
>>   .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 73 ++++++++++++-------
>>   2 files changed, 86 insertions(+), 47 deletions(-)
>>


--_000_DM6PR12MB39307EA02DE72479774D8FF297B79DM6PR12MB3930namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
&gt;<span style=3D"font-family:-apple-system, HelveticaNeue;font-size:14.66=
67px;display:inline !important">Or maybe just a list without default hint, =
i.e. no asterisk?</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<span style=3D"font-family:-apple-system, HelveticaNeue;font-size:14.6667px=
;display:inline !important"><br>
</span></div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
" dir=3D"auto">
<font face=3D"-apple-system, HelveticaNeue"><span style=3D"font-size: 14.66=
67px;">I think this is also fine meaning we are having trouble in determini=
ng the current frequency or DPM level. Evan/Alex? Don't know if this will c=
rash the tools.</span></font></div>
<div id=3D"ms-outlook-mobile-signature">
<div><br>
</div>
Thanks,<br>
Lijo</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Tuikov, Luben &lt;Lub=
en.Tuikov@amd.com&gt;<br>
<b>Sent:</b> Wednesday, October 13, 2021 9:52:09 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 0/5] 0 MHz is not a valid current frequency</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 2021-10-13 00:14, Lazar, Lijo wrote:<br>
&gt;<br>
&gt; On 10/13/2021 8:40 AM, Luben Tuikov wrote:<br>
&gt;&gt; Some ASIC support low-power functionality for the whole ASIC or ju=
st<br>
&gt;&gt; an IP block. When in such low-power mode, some sysfs interfaces wo=
uld<br>
&gt;&gt; report a frequency of 0, e.g.,<br>
&gt;&gt;<br>
&gt;&gt; $cat /sys/class/drm/card0/device/pp_dpm_sclk<br>
&gt;&gt; 0: 500Mhz<br>
&gt;&gt; 1: 0Mhz *<br>
&gt;&gt; 2: 2200Mhz<br>
&gt;&gt; $_<br>
&gt;&gt;<br>
&gt;&gt; An operating frequency of 0 MHz doesn't make sense, and this inter=
face<br>
&gt;&gt; is designed to report only operating clock frequencies, i.e. non-z=
ero,<br>
&gt;&gt; and possibly the current one.<br>
&gt;&gt;<br>
&gt;&gt; When in this low-power state, round to the smallest<br>
&gt;&gt; operating frequency, for this interface, as follows,<br>
&gt;&gt;<br>
&gt; Would rather avoid this -<br>
&gt;<br>
&gt; 1) It is manipulating FW reported value. If at all there is an uncaugh=
t <br>
&gt; issue in FW reporting of frequency values, that is masked here.<br>
&gt; 2) Otherwise, if 0MHz is described as GFX power gated case, this <br>
&gt; provides a convenient interface to check if GFX is power gated.<br>
&gt;<br>
&gt; If seeing a '0' is not pleasing, consider changing to something like<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;NA&quot; - not availab=
le (frequency cannot be fetched at the moment).<br>
<br>
There's a ROCm tool which literally asserts if the values are not ordered i=
n increasing order. Now since 0 &lt; 550, but 0 is listed as the second ent=
ry, the tool simply asserts and crashes.<br>
<br>
It is not clear what you'd rather see here:<br>
<br>
$cat /sys/class/drm/card0/device/pp_dpm_sclk<br>
0: 550Mhz<br>
1: N/A *<br>
2: 2200MHz<br>
$_<br>
<br>
Is this what you want to see? (That'll crash other tools which expect %uMhz=
.)<br>
<br>
Or maybe just a list without default hint, i.e. no asterisk?<br>
<br>
$cat /sys/class/drm/card0/device/pp_dpm_sclk<br>
0: 550Mhz<br>
1: 2200MHz<br>
$_<br>
<br>
What should the output be?<br>
<br>
We want to avoid showing 0, but still show numbers.<br>
<br>
Regards,<br>
Luben<br>
<br>
&gt;<br>
&gt; Thanks,<br>
&gt; Lijo<br>
&gt;<br>
&gt;&gt; $cat /sys/class/drm/card0/device/pp_dpm_sclk<br>
&gt;&gt; 0: 500Mhz *<br>
&gt;&gt; 1: 2200Mhz<br>
&gt;&gt; $_<br>
&gt;&gt;<br>
&gt;&gt; Luben Tuikov (5):<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drm/amd/pm: Slight function rename<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drm/amd/pm: Rename cur_value to curr_value<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; drm/amd/pm: Rename freq_values --&gt; freq_value=
<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; dpm/amd/pm: Sienna: 0 MHz is not a current clock=
 frequency<br>
&gt;&gt;&nbsp;&nbsp;&nbsp; dpm/amd/pm: Navi10: 0 MHz is not a current clock=
 frequency<br>
&gt;&gt;<br>
&gt;&gt;&nbsp;&nbsp; .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp;&nbsp=
; | 60 +++++++++------<br>
&gt;&gt;&nbsp;&nbsp; .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&nbsp;&nbsp=
; | 73 ++++++++++++-------<br>
&gt;&gt;&nbsp;&nbsp; 2 files changed, 86 insertions(+), 47 deletions(-)<br>
&gt;&gt;<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB39307EA02DE72479774D8FF297B79DM6PR12MB3930namp_--

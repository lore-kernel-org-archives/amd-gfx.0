Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681F6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 20:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29DD961206
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 20:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 29DD961206
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73806EA2C;
	Mon, 18 Oct 2021 20:19:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 173296EA2C
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 20:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtsXQQzUwvdKi8UMVvtvkXJzWR1EBgtyoXSxLE8zMPSFUhPagkiWMEvRtsV1qnADzbgGdw9LmD4cv+U/8/lcnrtj764kQ3q9kvBVwq0tJGU1KXiNo9FAkId+UHIXfOZ2IcRBx7CWNNtSxv4LPZhjerMs9PprPVfBTI5xYhwGBdnDg3RCSoUU5Ecq0nUMA/fNljfjlsNLs3rXO0pkgovczaaZOaJq0V5xMf2u34yJ6TVwpDcrPVDhgKFfJ7k+J8GksIWSAED6ADxDwbONO0qgsmsoMseRc+q++znazcJFHxIObL60WH+feMPzbrl9CgU38JxVn+pmhdLe9eAjAU72Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08J99sk/LM4hdRA5JCVEzQzhTVKFB8q2YtUMCuUPh/U=;
 b=YaYMTzsPG4en4NNzzCY1ZBW0TiwExSXMJbgacO6DtDVFrLQnIBC9VSpCQgh+GhAWMdMLfzBlrsIRwC5oQcZaIoFbWkWuztnLm4eomXz/qx5NVcQr7RXAAlqIiCwQ4/RAW4APZVfnR1cAp8oeqM/DzDyl3DaWcA6BkFCf7r6Yl0mVjbwOIfP31JeeJXIqYKv6xYhbayiTEkw2x8676e4LSUX/epsjwzclVziTWa33b+hXk+8FqqCjpLfEWv55962aUs+hS3oZfP8Y4WFJ0206WJM4Mcww/sdqVQvhHIKvbBLCuP68dAn0vxkZDPga3O4FCjyCAJ9nqvX2IomsmEQF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08J99sk/LM4hdRA5JCVEzQzhTVKFB8q2YtUMCuUPh/U=;
 b=AhwMY/ibV89eAeY37F1BNmetaYe3XuTcGdS5lgYIEGrA4vyH0tFaKDfIU7x2M4O5Oy7+w0kmUyNLE5W668Ny1o37FA+UiRiqcIvDLskqQGM6kmLQJU9XZNzjxtEqeFSkKBI/WQlLymUcRcRVaqnzIa2asS7rpZvktHHtsu7UVsw=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL0PR12MB5553.namprd12.prod.outlook.com (2603:10b6:208:1c9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Mon, 18 Oct
 2021 20:19:05 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::90da:399c:fe89:3499]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::90da:399c:fe89:3499%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 20:19:05 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Russell, Kent" <Kent.Russell@amd.com>
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency
Thread-Topic: [PATCH 0/5] 0 MHz is not a valid current frequency
Thread-Index: AQHXv9/zYw/uuqEV9Uy7xf/Rm2xRbqvQUc0AgADLY4CAAAx0gIACLlUAgAXimmc=
Date: Mon, 18 Oct 2021 20:19:05 +0000
Message-ID: <BL1PR12MB51443E4EA64480401839E135F7BC9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
 <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
 <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
 <DM6PR12MB26196111DA43A1EE11266558E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB26196111DA43A1EE11266558E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-18T20:19:04.520Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 2370456a-7e39-e6ac-8f58-b570b5ee4e4a
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9ea7f11-8e64-4c70-a5dc-08d992748879
x-ms-traffictypediagnostic: BL0PR12MB5553:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB5553435E091E59F676FEC4CCF7BC9@BL0PR12MB5553.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JDfRGdENMkE+alsTyl0KMkL1hVCiknjs/UXlzRJCqlLH+IHi3JE78nDXKWDKG51Nrou/ILY5tMTp1hjFcZFlulgZnTLoX5+NqoE2KD9bvweSJqB184Nxs57h3+e899DKlDNHQvxl3lc9WDvp4YTI6sukCsoYSgj8oomjhCzw9zsYGMNvGRwhIQrFMyton0C1kcgSS5cBBYWmpb2FiK1qDKCcnocQxVX+l7G3MBvgGw2CCJWQ8XD8zIThmtVTMvQKNxUWaLH/KmE3kt18+5oEBPfYAyKEYTeEyIzQN4eW7f5R1kWNqh9GO77XNurIyJ233qK32iHaHK1AWdvq/08YoPufTt5ArqO/141qK6mTUYwC2u156KOXOnOE7xjkVf2sVcalgU1W0H9Adu3CpgBf12z+Ty6HbiYW+1BeVzV2CCioLfAzyS60u4yqx+k4yDABr2FVQLDOp14sGBrUW6nz2oVVe/VTVGm8iXMl4ljBnQjgCcHPBKN62hruJRSyYWjXXZSVhca8NlDSaaN4c3u1dA5JEl1oe1w2LFV4aDDlGivpCemHm1Rfbm+X3Gm2AAqU5ItYmLPN/CINCKbWecr4kF1rGWFAO9g2mN16G8/qlMXb0s/f/EQSh5DHYurw6JfINhXYPi5kdI7sjmh/89s5/BLlYg+z/fS/597knXrj/b7+kxdHDyQFdmaNaj/OtbAsWGfXhylmdoQajHU4ZV1Btw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(508600001)(38070700005)(8676002)(66446008)(2906002)(4001150100001)(83380400001)(6636002)(19627405001)(66476007)(66946007)(66556008)(19627235002)(33656002)(110136005)(316002)(38100700002)(52536014)(122000001)(8936002)(5660300002)(76116006)(9686003)(186003)(55016002)(64756008)(86362001)(71200400001)(26005)(53546011)(6506007)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9sPYfTluDFlReJ+OOmyG87PN74knR1hwyQ30tCKYHIWalJn04PgiiFVcyj+r?=
 =?us-ascii?Q?F0d8oOaosy6tvOFy50Rp+FPYkAElt6RAOSKcYR82ZnlvmrEvesvXztftIGBa?=
 =?us-ascii?Q?6FXS8JLg2vm6vFcktaeEfl1UI33M/7qfAtlGU33hm3otOum9RUKEbIBsdYdv?=
 =?us-ascii?Q?PKbN3+DVW3ocdsuChWhCN6RzTw10T6yPLiLO6LzETltpEfIaRVgrZHNWmrsR?=
 =?us-ascii?Q?Bz9kc4wr+eKC3JvxXlWYKpysFbx8sNmF8tLXj7ldpdRCtWsvk78NXHodrtGv?=
 =?us-ascii?Q?9jO6fNgtlz1vo90tTe0AOrCcBK9oVH9SAK1zEOULG5jYAatku3rNZmJ/MU6W?=
 =?us-ascii?Q?XPl9rQQPKTbMNs3EWA6ZpCsGTzShqphMA/mdAQ6+tvpF0sc14dScvtr0k4vF?=
 =?us-ascii?Q?zbHlmHPZSL7SN2L1eHOyVUdmEQ1M/q8Y2GLNKuRIKDonh1FfmbJyumZCH4fU?=
 =?us-ascii?Q?dVhy2SUiOQsTlQ7ZXBT0mqEyZEvnn7nO2TLYwnxmGIsZu0/LZDmBDsfL+L76?=
 =?us-ascii?Q?Oer7q6eZdqK7eIzd/3RugcMtCrDf0pLwg9YmQfgsIn9Sr5sBix0C8DM3FLP4?=
 =?us-ascii?Q?85bk4SFM3pWgM1rk+Fd20l7OrWPThYVenQneFyAPjO8FCTBfgSaeIEVZNrsS?=
 =?us-ascii?Q?UhkJEVnTtg7mGudNbrDWWyKptsDTfwiueyaVFjP2jEN24rleZQOIG5RI5sQH?=
 =?us-ascii?Q?yBVn8oxqBPuuJ7dYUf5vfmbhQoGA8gbw1xk7YfxGadzHww920VGDmqT3JLQX?=
 =?us-ascii?Q?9j/EH/KCH0HU4O2fhx7VbSuxBbSSVpOML6PAhbri7HEQ6xsbKCwIGCRzQBlJ?=
 =?us-ascii?Q?k1wWBR259p0HtpiNu6RkvwnzFkheGM6X+ZTJ0mqyXpSOJCEYOP7nAzHl0Zvl?=
 =?us-ascii?Q?xx6l71xql3vcjkSbUT/22r7udLgV2VQSBAyWX2CYaxL7TmtoSWz0a/qbfCOo?=
 =?us-ascii?Q?GJ+wBvcJfSgIDDYhHDNKaEjq21G147tA7gX9h7ofQD1hYWJDcD71zg5NkOr9?=
 =?us-ascii?Q?iujZMQHA9HbT+M4fyZZksFZPaBxOLFMD62oqwjLuN+PC732uBIZz+UE/rhqF?=
 =?us-ascii?Q?UPLlYL8Xyjiumx5yaJBDL6nzifXDOND/DUxd7nb+0T67+kpykRn/WmNe3aQy?=
 =?us-ascii?Q?D53hNumN4nqehHX/NORDwMIxFN7OQIWt9mwfAUZUYNLZEfgfP+ckQVyb4Rbp?=
 =?us-ascii?Q?BTDvNaTVss5EGk5U+p8KSF4cH6/7/E26N3xDtCEI0KYNRscnS4+aFgu5lUJo?=
 =?us-ascii?Q?LlugFLcrIxKYRWJyAh03j8Zrs1Nxcs27wEQ1eWGFwImnNen1QoLJ/39qSmUa?=
 =?us-ascii?Q?LGSdi5vu68bjjMBmr7LIkOI0?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51443E4EA64480401839E135F7BC9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ea7f11-8e64-4c70-a5dc-08d992748879
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 20:19:05.1727 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hk0DGyEmiAaRDG2MWfMTjjuHUqo0IEA9VhWARlkCY6J3AksB68BsO2FEAwjZQOCc21doN4+smiCojERpEKIpmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5553
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

--_000_BL1PR12MB51443E4EA64480401839E135F7BC9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

We the current behavior (0 for clock) already crashes the tool, so I don't =
think we can really make things worse.

Alex

________________________________
From: Quan, Evan <Evan.Quan@amd.com>
Sent: Thursday, October 14, 2021 10:25 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; Tuikov, Luben <Luben.Tuikov@amd.com>;=
 amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Russell, Ke=
nt <Kent.Russell@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 0/5] 0 MHz is not a valid current frequency


[AMD Official Use Only]



+Kent who maintains the Rocm tool



From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lazar, L=
ijo
Sent: Thursday, October 14, 2021 1:07 AM
To: Tuikov, Luben <Luben.Tuikov@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 0/5] 0 MHz is not a valid current frequency



[AMD Official Use Only]



[AMD Official Use Only]



>Or maybe just a list without default hint, i.e. no asterisk?



I think this is also fine meaning we are having trouble in determining the =
current frequency or DPM level. Evan/Alex? Don't know if this will crash th=
e tools.



Thanks,
Lijo

________________________________

From: Tuikov, Luben <Luben.Tuikov@amd.com<mailto:Luben.Tuikov@amd.com>>
Sent: Wednesday, October 13, 2021 9:52:09 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>
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

--_000_BL1PR12MB51443E4EA64480401839E135F7BC9BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;" al=
ign=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
We the current behavior (0 for clock) already crashes the tool, so I don't =
think we can really make things worse.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Quan, Evan &lt;Evan.Q=
uan@amd.com&gt;<br>
<b>Sent:</b> Thursday, October 14, 2021 10:25 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; Tuikov, Luben &lt;Luben.=
Tuikov@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedes=
ktop.org&gt;; Russell, Kent &lt;Kent.Russell@amd.com&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 0/5] 0 MHz is not a valid current frequency</fon=
t>
<div>&nbsp;</div>
</div>
<style>
<!--
@font-face
	{font-family:"Cambria Math"}
@font-face
	{font-family:DengXian}
@font-face
	{font-family:Calibri}
@font-face
	{}
p.x_MsoNormal, li.x_MsoNormal, div.x_MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
a:link, span.x_MsoHyperlink
	{color:#0563C1;
	text-decoration:underline}
span.x_EmailStyle18
	{font-family:"Calibri",sans-serif;
	color:windowtext}
p.x_msipheadera4477989, li.x_msipheadera4477989, div.x_msipheadera4477989
	{margin-right:0in;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif}
.x_MsoChpDefault
	{font-size:10.0pt}
@page WordSection1
	{margin:1.0in 1.0in 1.0in 1.0in}
div.x_WordSection1
	{}
-->
</style>
<div lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:b=
reak-word">
<div class=3D"x_WordSection1">
<p class=3D"x_msipheadera4477989" style=3D"margin:0in"><span style=3D"font-=
size:10.0pt; font-family:&quot;Arial&quot;,sans-serif; color:blue">[AMD Off=
icial Use Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p class=3D"x_MsoNormal">+Kent who maintains the Rocm tool</p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div style=3D"border:none; border-left:solid blue 1.5pt; padding:0in 0in 0i=
n 4.0pt">
<div>
<div style=3D"border:none; border-top:solid #E1E1E1 1.0pt; padding:3.0pt 0i=
n 0in 0in">
<p class=3D"x_MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.fre=
edesktop.org&gt;
<b>On Behalf Of </b>Lazar, Lijo<br>
<b>Sent:</b> Thursday, October 14, 2021 1:07 AM<br>
<b>To:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 0/5] 0 MHz is not a valid current frequency</p>
</div>
</div>
<p class=3D"x_MsoNormal">&nbsp;</p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Arial&quot;,sans-serif; color:blue">[AMD Official Use Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt; font-family:&quo=
t;Arial&quot;,sans-serif; color:blue">[AMD Official Use Only]</span></p>
<p class=3D"x_MsoNormal">&nbsp;</p>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">&gt;</span><span style=3D"color:#212121">Or maybe just a list withou=
t default hint, i.e. no asterisk?</span><span style=3D"color:#212121"></spa=
n></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">&nbsp;</span></p>
</div>
<div>
<p class=3D"x_MsoNormal" style=3D"background:white"><span style=3D"color:#2=
12121">I think this is also fine meaning we are having trouble in determini=
ng the current frequency or DPM level. Evan/Alex? Don't know if this will c=
rash the tools.</span><span style=3D"color:#212121"></span></p>
</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
<p class=3D"x_MsoNormal">Thanks,<br>
Lijo</p>
</div>
<div class=3D"x_MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p class=3D"x_MsoNormal"><b><span style=3D"color:black">From:</span></b><sp=
an style=3D"color:black"> Tuikov, Luben &lt;<a href=3D"mailto:Luben.Tuikov@=
amd.com">Luben.Tuikov@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, October 13, 2021 9:52:09 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 0/5] 0 MHz is not a valid current frequency</spa=
n> </p>
<div>
<p class=3D"x_MsoNormal">&nbsp;</p>
</div>
</div>
<div>
<div>
<p class=3D"x_MsoNormal" style=3D"margin-bottom:12.0pt">On 2021-10-13 00:14=
, Lazar, Lijo wrote:<br>
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
&gt;&gt;</p>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB51443E4EA64480401839E135F7BC9BL1PR12MB5144namp_--

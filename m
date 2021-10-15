Return-Path: <SRS0=EPaF=PD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BAEC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 02:25:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DF2B610D1
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Oct 2021 02:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3DF2B610D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B8F6E219;
	Fri, 15 Oct 2021 02:25:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BB36E219
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Oct 2021 02:25:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7Wf6vAshmByjP35sBxKvOiVgGk1DXd9M/1sMUWZZX1ioN22ciKZlSAH3tgUzSQxJx+2ZuQ6PFA8rAjpDBcduZ/yvvUzjGhC0NoDdw4cdvVn0TcSyB8eviZbPq3d2HCd/6PhswHvZ2F/WcCJdQNqZpqBv90OxMu/PKWJynndSbpzZjNHME8F3wqEMIBqCvj/WjrvRGimZbjpohrDWVnYg9rWyiQAdh9e20dqKBMYtu6r6sCHdY6S4aD7YCCXjtuATJ19PD9u5fcTlyrmWWF7rageetGFrmF1Y/axg8/Xmq6mkeeDFPn53ZElIrnUeXpX+O09MfRgpc6jodw/f7Z9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgPcGU0Sb22atbnpe5XV5FOteC0gTxGtiWUOrAoN3LE=;
 b=REXZMsJrtQ7ehKlBCc0v2ZJ9SVnB+gjNF8kn8gEdPGTHYwAT972/sTXJeckeVpZhopHOKGC7pKEXVHWWVXyjMkwE6cPCBHXskeMio6sGEIzPcPK2VL//5afKfoH5BoBY3SV/Pi+Xt8+pSr7oyjz3fGSnHM+RMzrtl7Z/tv0Be7l0OyP7irehHUPFw/TwkocJneVavP1pvJDAV24iCL5CcNcL1IZYPeEG+C0MqJh6H+jUbLl4m4y9q9ggbS3deXvaRG7pJbp6MsEuCzTeoTq55tSLpFTkCQ8ugU5nedBWJg9y8Ss0JelkWQ9KSmBog0LTuJX9dtkBAokDkJK3npm78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgPcGU0Sb22atbnpe5XV5FOteC0gTxGtiWUOrAoN3LE=;
 b=uHHWapyk1tmPzft0oLyhP1d36gONMZeNpwLePDnZZbvz9wPA2Q3JyZf/+zGvHBuqtMcNMhuZHymKH0OazWxtIuxvyUJwxiCbbUxHLQYyykv45Vj6Tw9umO12BaZDxMhS+97e6PEiAgpXmzPUlJduCb3YCF8g2PgzIbB6zxukKwk=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB4436.namprd12.prod.outlook.com (2603:10b6:5:2a3::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15; Fri, 15 Oct 2021 02:25:04 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 02:25:04 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Tuikov, Luben"
 <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Russell, Kent" <Kent.Russell@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 0/5] 0 MHz is not a valid current frequency
Thread-Topic: [PATCH 0/5] 0 MHz is not a valid current frequency
Thread-Index: AQHXv9/26Aazo+zq7k25iwVqG7vigqvQUc0AgADLY4CAAAx0gIACLg1w
Date: Fri, 15 Oct 2021 02:25:04 +0000
Message-ID: <DM6PR12MB26196111DA43A1EE11266558E4B99@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20211013031042.53540-1-luben.tuikov@amd.com>
 <858da53c-7937-3ebf-360d-f20f30f825d9@amd.com>
 <e3d94e8a-ea9b-85cc-8e85-2ee2e6725f2f@amd.com>
 <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB39307EA02DE72479774D8FF297B79@DM6PR12MB3930.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-15T02:25:02Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c8af9fe6-e7dc-450d-94d8-08d98f82ff70
x-ms-traffictypediagnostic: DM6PR12MB4436:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4436287588194F84ABC0B518E4B99@DM6PR12MB4436.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xr6F5iadzmCau7Gu+FpFjGZLdJM1H7iHu+sEQPN36rNmATl1Fezv/iY8l/dcu5P3NW9ZyBiD13tEBwbP9/+090f44CisATnagjsCsjnoqukThTDInENttDaDIeQAGvBXMDCY5qaDhu49XbahiubcYvyo3k534Z300UYhuIEFcfJOucRbFG+dyTKYlWGpJ79sQECIq7JvNkLhBk/Au7M0EqzF2CmT1hc6MiRTzhF+W4Z+p3pE2Z8dfFhwevEe8kkljEC3/SF1RSYgaZRUGKJd+In4LUu8DqweQ0aoH6XNiEgMJQpLip0YqsC/qR/p8aV66weN/NvwrZmt77B82Y8NPM9+I//KQ2XU/KEi9AapJE7FbfQWSRINwrfpw0Nna/7Hmbl91w2zNGJ38BoqAl5e2Fbq+Ljpp/uQin1MTxzRWTmwU67xpxDZTJ/rnNKfZ5E0fPFqe6ZWc7saBeCqs40exEWn8LOfiDVXbD1oWQLBltMSMUY8SCnZFwYTP8iPZWFEVNH9aQ4KY7/UUoeRSU+34CRWa5R5KXg2dl52W1WVwuW2mpwJ+1M86iHqgIJlEAZbuUNDUeGPuDHBsvWCdnrWVQhbrKcemCwrtJNCBWKEIl6HZBdnBZ0lowAMcgSS6Rphhiid0bXfVM4OdQcU5gmVitREXQ9j44Tk46YmbUpEVhLLrdk1TRSlgDBvuO96rruvlVOUg0FZ9S3nGB75bbIBOg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(33656002)(38070700005)(83380400001)(5660300002)(186003)(66476007)(9686003)(508600001)(55016002)(4326008)(26005)(110136005)(316002)(122000001)(2906002)(7696005)(86362001)(38100700002)(66446008)(8676002)(6506007)(6636002)(8936002)(4001150100001)(76116006)(52536014)(53546011)(66946007)(71200400001)(64756008)(66556008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sTPm4nuN4qYdMOVNIYRXRkMtdeLrLo5R5cTIsSnEyrQsL2mkl/IRcgXeac+g?=
 =?us-ascii?Q?9D569iQ37t3dIc27IcS4QnRiiscCEqJ4Ua5PyQm0tZhE4BHXKHzfA7p4OHKe?=
 =?us-ascii?Q?U+fLxMNTZjBOiidJNH3NuHgGSYLE5abd4Wxh8xbh0QKz8309UAwwjawEwrQC?=
 =?us-ascii?Q?5Bq/dx/5Y86+qZaI1vTyUjO9iBf43GUBXkBu4m/2V0SvC5LNyWiPgiF8N5P1?=
 =?us-ascii?Q?dxh/2kPTRkN06rQLXekV+c6kBPEdZ7289szE3vSgE/HzkUqXQ0du6M4N5ngC?=
 =?us-ascii?Q?74z4hVMOCKP2bsiHFNGG91uA0iwZcuDxc6C2Bb1I/l/8HvH1C7j2stP1g0+q?=
 =?us-ascii?Q?nlNyjdQC8nV6wg/fykqaxGk+VlDV//x8kr3lLyvGSHplIsYPcsH5yeWsxwvq?=
 =?us-ascii?Q?ROJFXMbncVsLuGn8ZQ22KORzy8UJzeoZW/4aSja6IORevBHGNnAc0E1eaPPs?=
 =?us-ascii?Q?cm/4LaMSD9gWOudVVbR/q3YRyMV4dsWcQJZWWsHXrAz/smcl583WytP8b16Q?=
 =?us-ascii?Q?l8C/5O5UAVFIuqvtaaSvcjbsqf3ogC9WKbQLKKhmI/Dbozicd/FcBnxOEhTH?=
 =?us-ascii?Q?f4vo4DvcqOfV5lJLDoOj2Q0uoswz3damFjycZBwhBC5xvSH8Wqdi0IAJBmA/?=
 =?us-ascii?Q?jWYnj2JmoZNLOFWZF5YOWLh2a7QAxMpZTjabJFWWbyLEOMBpFa+qDAy/C06o?=
 =?us-ascii?Q?W+a+DpCyTDUmyaIrIHftgGxLfLVIgRpT53qPkMau3zDilv4x7IPp1eXe9QZF?=
 =?us-ascii?Q?rfyXnWV+CGk81MnLP/cR2WLBI8m2g/8adiXKclT/GGCdH8sMmQewQrk1hliK?=
 =?us-ascii?Q?Aq3aDr0rrSbLt2xFigBk5auWZbliyoRM61C36tOm1GS7fYWBLAU8FMZs9kyX?=
 =?us-ascii?Q?Z8o/y+LNQqLYUtyQ3lSBS8Fu1FtKmwFYUvzRvlywsHjcXceDWLsjGBQ0JMdN?=
 =?us-ascii?Q?ytr+x3SIF484hhCg1ZavcoIeWiSsSWNRhqlIq7AgaPfoOGrT/cw3Dx+kUKa5?=
 =?us-ascii?Q?IPJJ9+/7UK5s9m3iXsPT+sSCXF8v6lZ9qbC2ZUvM3dpiCvh2zDpV/EWiJqSt?=
 =?us-ascii?Q?DGyvpeu8Xoi1vKKhgwZW0XShqQo4X+GhNB//G0WzgUapjtAVS2OfJqlSf2Of?=
 =?us-ascii?Q?g3wUpCTsIFAyg/7aK5uOoa3Ph+8GxW9Mu6auCsvBbCDVNWasUeeMstOc3D8P?=
 =?us-ascii?Q?2RLBXzQYwRsHtfL2iwMBU0k6jKnQ08Y4yVrWk/y4gOSI+bkfFgLcqV+8DLv5?=
 =?us-ascii?Q?axrQdeJuikX4ZHE8vmZrsC2p4cVydVDsApm9jcfY8fiQ9SC+2M8BRUcou9Hs?=
 =?us-ascii?Q?9WChRepujfx+rGiNZ3Ur0kg9?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB26196111DA43A1EE11266558E4B99DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8af9fe6-e7dc-450d-94d8-08d98f82ff70
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2021 02:25:04.2635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j2YNyKws0xkphNHp2vqVNztX2SKNM3+n5uefsoUI5PAiPNvWi+hAzsHTtNMRI2Ek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4436
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

--_000_DM6PR12MB26196111DA43A1EE11266558E4B99DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

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

--_000_DM6PR12MB26196111DA43A1EE11266558E4B99DM6PR12MB2619namp_
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
@font-face
	{font-family:-apple-system;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheadera4477989, li.msipheadera4477989, div.msipheadera4477989
	{mso-style-name:msipheadera4477989;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheadera4477989" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">+Kent who maintains the Rocm tool<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces@lists.freed=
esktop.org&gt;
<b>On Behalf Of </b>Lazar, Lijo<br>
<b>Sent:</b> Thursday, October 14, 2021 1:07 AM<br>
<b>To:</b> Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 0/5] 0 MHz is not a valid current frequency<o:p>=
</o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only]<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">&gt;</span><span style=3D"font-family:-apple-system;color:#212121">Or =
maybe just a list without default hint, i.e. no asterisk?</span><span style=
=3D"color:#212121"><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"font-famil=
y:-apple-system;color:#212121">I think this is also fine meaning we are hav=
ing trouble in determining the current frequency or DPM level. Evan/Alex? D=
on't know if this will crash the tools.</span><span style=3D"color:#212121"=
><o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p class=3D"MsoNormal">Thanks,<br>
Lijo<o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Tuikov, Luben &lt;<a href=3D"mailto:Luben.Tuikov@am=
d.com">Luben.Tuikov@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, October 13, 2021 9:52:09 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH 0/5] 0 MHz is not a valid current frequency</spa=
n> <o:p>
</o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">On 2021-10-13 00:14, =
Lazar, Lijo wrote:<br>
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
&gt;&gt;<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB26196111DA43A1EE11266558E4B99DM6PR12MB2619namp_--

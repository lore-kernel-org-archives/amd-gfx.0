Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB231C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 19:49:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5DD24655
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 19:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rtAKSyBS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F5DD24655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5830A6F8A1;
	Wed, 22 Jan 2020 19:49:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 743376F8A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 19:49:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEP+WzvJaQ/8ixOjXOW4TkjTezTAhvy84AJl1bP24qZPBqjjE98S+mxAPoVYJyKHNzGrQdWrrld+K48eJyBFpPaBnQ72a54SLwQ3igg1u9BfatWRl8ISIr1TCGrcZ+4FLmacDDkuf+KffpqCxZFDV7wVJ4rBdZBjiuLHnth0YcuIcGxUu6AAmss7cy0rkghK1CvFk1fc5S7Q4EIQeEi7l76Rw5VCH9tauIn3nbDMVZMFtj81Az2sa15EDwcWOyJkE/lAzKObhEST6M219R0OwdTyUbRDpgqLoUDQoIWX4PQbQSYsMk+hmFZUHaz9sFjTfZatVTBfTOFRvngTLucHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyLWwV0X8Yxnk2TAJ4ox2YXuhnZCfDZXuMl3or7Gss4=;
 b=WKfn5EnqtpHYUYS+hTr65CwlBehUo+8PgyRl5i/fbgTlVR8D4SOLJ2O+5GPRMydDy/Kswt1mRA5AveHSn85BkjfpB+hWTTS4vLjEs/EZOjumUBjTzRmtX8lBx7GCOhkvnTY0lQe7NnpVvdVTN+uhJEcGOaSPIx0cg5o+qvQBFZmiUD8iPhL4TZljl+gNSVmbY8xxe+d62BHDnzJqGKE0balV1LrxKe7TPRFwlA3icaUGAfRuKOyurXUg9kSc0hwK2wQhK5BaJEVMHlz8cWInK6xxBJQ+lQdXYZjw6FFhETWqxVwag2MKAWI828aEKT4hKhIldNMaBSnDQbGs4rPJvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyLWwV0X8Yxnk2TAJ4ox2YXuhnZCfDZXuMl3or7Gss4=;
 b=rtAKSyBSKUrNk9U+R1p4juU/eGDTCk2hZ9VwT7HquZv12J7IZ/mwjaFvAA5OQdqC89QkEEKdktIxg4bueIdjur0Fy8GoJJV+wF2tl/wvM9W/2paScfSyNRn9rlnZ2LxVahkg35lr+jWAUYIjygF3iRjEX7Mg2qT8oQh0sEf3JTA=
Received: from CH2PR12MB3912.namprd12.prod.outlook.com (52.132.246.86) by
 CH2PR12MB3736.namprd12.prod.outlook.com (52.132.246.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 19:49:42 +0000
Received: from CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::35e4:f61:8c42:333d]) by CH2PR12MB3912.namprd12.prod.outlook.com
 ([fe80::35e4:f61:8c42:333d%6]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 19:49:42 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/5] HDCP SRM interface
Thread-Topic: [PATCH 0/5] HDCP SRM interface
Thread-Index: AQHVzKvG5kVag1x7lkKHo0+XkeY/A6f24/yAgAADIYCAAAXWAIAALcqAgAAF6mQ=
Date: Wed, 22 Jan 2020 19:49:42 +0000
Message-ID: <CH2PR12MB3912DC3EC38450B31ED2FFFBF70C0@CH2PR12MB3912.namprd12.prod.outlook.com>
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
 <55a3fd2d-c2ed-4af0-543e-9850118b722a@amd.com>
 <CADnq5_NO49aT6eSDywE20h6XZSF_D4WvCyQo30cXwRMvU1YmoA@mail.gmail.com>
 <7eca48bb-d1e8-a1c4-0812-665438a38ecb@amd.com>,
 <67fb6764-7add-372c-95ae-8294c6e1c1e9@amd.com>
In-Reply-To: <67fb6764-7add-372c-95ae-8294c6e1c1e9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=True;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-01-22T19:49:42.160Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=AMD
 Public; MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged; 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.59.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: af3580f9-36b1-4dc0-933a-08d79f7439a0
x-ms-traffictypediagnostic: CH2PR12MB3736:|CH2PR12MB3736:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB373677DE091C69B36BAF38B1F70C0@CH2PR12MB3736.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(199004)(189003)(966005)(45080400002)(478600001)(4326008)(2906002)(52536014)(71200400001)(8936002)(81156014)(19627405001)(76116006)(81166006)(186003)(8676002)(53546011)(7696005)(316002)(55016002)(66946007)(66556008)(9686003)(33656002)(86362001)(64756008)(5660300002)(6506007)(66476007)(66446008)(54906003)(110136005)(26005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3736;
 H:CH2PR12MB3912.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l3AFd6xbeO4EY8QaO5CrpXr8RTP9WZT9f1rxQYPyi8m6+foF9p1cvO6xtye49qyX3DGWYwUqy2DY8sQ3tx1m6t14OISo1QYf9RTBKjRJ1d+ksP+Iw3rgC9Y9xkomMMCu29G4dfWhRWNUAwSsaqsAgB1Ajkkk5fzJR7ULJ0W/3yr68kMVOR4SBXlYfLQ2JywN8aaAgiDXbvNgYlzCc4U97iLcuvnKIMQ4wWbet2aLVxgATAZj8Bcd3py44VyXjuFvjlvMU3aH8m9ETI8caQ/wp0tNdhxXAg5W2XbrH+3O3ThR6tIKDLO9couEGbHW2WmneDwK5gYthRcXLr6JvSjOZUZ9Qcbgxgkk4FyD58fUkYrpvhx1rysT4lTQk7EegO+kFhSmIgNk2AsQhDQzmsY+oenxnMe8zT8ysHDlGjCcujxlKVN84igt50/TUidRfXz0tiFoNseDHhnM/XHiaNg6GiAKpFyQ/z3xt0jPZoJUdJU=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3580f9-36b1-4dc0-933a-08d79f7439a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 19:49:42.6622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmWy3yCA3F1rcjt1zdr5sUGD0iD7FoKrR7KRVXkB7pVQADgjEmgfs65Dwm6VcWFjd/LbAmJ6PkXyIBqKkWdO9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3736
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
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0946515435=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0946515435==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH2PR12MB3912DC3EC38450B31ED2FFFBF70C0CH2PR12MB3912namp_"

--_000_CH2PR12MB3912DC3EC38450B31ED2FFFBF70C0CH2PR12MB3912namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Public Use]

If you resend the patch set, it might be good to include the script in the =
series for reference as well.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Harry We=
ntland <hwentlan@amd.com>
Sent: Wednesday, January 22, 2020 2:27 PM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Alex Deucher <alexdeuch=
er@gmail.com>
Cc: Wentland, Harry <Harry.Wentland@amd.com>; amd-gfx list <amd-gfx@lists.f=
reedesktop.org>
Subject: Re: [PATCH 0/5] HDCP SRM interface



On 2020-01-22 11:44 a.m., Bhawanpreet Lakha wrote:
>
> On 2020-01-22 11:23 a.m., Alex Deucher wrote:
>> On Wed, Jan 22, 2020 at 11:12 AM Harry Wentland <hwentlan@amd.com> wrote=
:
>>> On 2020-01-16 3:29 p.m., Bhawanpreet Lakha wrote:
>>>> These patches adds support for SRM loading. By providing an
>>>> interface to the
>>>> usermode
>>>>
>>>> SRM has to be persistent and since the kernel cannot directly write
>>>> to system
>>>> storage we need to provide an interface so that the usermode can do
>>>> it for us
>>>>
>>> We'll want to elaborate a bit more on why and how this is done. As
>>> mentioned on my patch 2 comments I recommend to do this there as the
>>> cover letter is lost after merge.
>>>
>> You might also want to cc dri-devel if you resend to get more reviews.
>> I'm also not crazy about having to update the file in chunks, but I
>> don't have any better ideas off hand.  Maybe an ioctl would be
>> cleaner?
>>
>> Alex
>
> The kernel can only send PAGE_SIZE (4KB) at once, so if the file is
> bigger than PAGE_SIZE (max SRM is 5KB) it will send it again until its
> finished (unless we increase the page size).
>
> From the user space its just a single command to read/write
>
>     save to storage : cat /sys/class/drm/card0/device/hdcp_srm > file
>
>     load from storage : cat file> /sys/class/drm/card0/device/hdcp_srm
>

Please also add this info in the patch description or cover letter as
well, including how you iterate for a large SRM. A simple copy-paste
from the shell script should suffice. It's a bit hard to see how this
interface is being used from userspace, especially around the get/set in
chunks.

Harry

> I will send it to dri-devel after fixing what Harry suggested.
>
> Thanks
>
> Bhawan
>
>>> Harry
>>>
>>>> Bhawanpreet Lakha (5):
>>>>    drm/amd/display: Pass amdgpu_device instead of psp_context
>>>>    drm/amd/display: update psp interface header
>>>>    drm/amd/display: Add sysfs interface for set/get srm
>>>>    drm/amd/display: Load srm before enabling HDCP
>>>>    drm/amd/display: call psp set/get interfaces
>>>>
>>>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
>>>>   .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 182
>>>> +++++++++++++++++-
>>>>   .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   9 +-
>>>>   .../drm/amd/display/modules/hdcp/hdcp_psp.h   |  26 ++-
>>>>   4 files changed, 212 insertions(+), 7 deletions(-)
>>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7C6045839ca9f14797ff3a08d79f713094%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637153180855191595&amp;sdata=3DevmiajEJOkOb2L2=
GgUxg6JsWadR99PgoTE%2F6cQoBKfs%3D&amp;reserved=3D0
>>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C6045839ca9f14797ff3a08d79f713094%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637153180855191595&amp;sdata=3DevmiajEJOkOb2L2GgUx=
g6JsWadR99PgoTE%2F6cQoBKfs%3D&amp;reserved=3D0

--_000_CH2PR12MB3912DC3EC38450B31ED2FFFBF70C0CH2PR12MB3912namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#317100;margin:15pt;" al=
ign=3D"Left">
[AMD Public Use]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
If you resend the patch set, it might be good to include the script in the =
series for reference as well.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces@lists.freedesktop.org&gt; on behalf of Harry Wentland &lt;hwentlan=
@amd.com&gt;<br>
<b>Sent:</b> Wednesday, January 22, 2020 2:27 PM<br>
<b>To:</b> Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Alex Deuch=
er &lt;alexdeucher@gmail.com&gt;<br>
<b>Cc:</b> Wentland, Harry &lt;Harry.Wentland@amd.com&gt;; amd-gfx list &lt=
;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 0/5] HDCP SRM interface</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
<br>
On 2020-01-22 11:44 a.m., Bhawanpreet Lakha wrote:<br>
&gt; <br>
&gt; On 2020-01-22 11:23 a.m., Alex Deucher wrote:<br>
&gt;&gt; On Wed, Jan 22, 2020 at 11:12 AM Harry Wentland &lt;hwentlan@amd.c=
om&gt; wrote:<br>
&gt;&gt;&gt; On 2020-01-16 3:29 p.m., Bhawanpreet Lakha wrote:<br>
&gt;&gt;&gt;&gt; These patches adds support for SRM loading. By providing a=
n<br>
&gt;&gt;&gt;&gt; interface to the<br>
&gt;&gt;&gt;&gt; usermode<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; SRM has to be persistent and since the kernel cannot direc=
tly write<br>
&gt;&gt;&gt;&gt; to system<br>
&gt;&gt;&gt;&gt; storage we need to provide an interface so that the usermo=
de can do<br>
&gt;&gt;&gt;&gt; it for us<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; We'll want to elaborate a bit more on why and how this is done=
. As<br>
&gt;&gt;&gt; mentioned on my patch 2 comments I recommend to do this there =
as the<br>
&gt;&gt;&gt; cover letter is lost after merge.<br>
&gt;&gt;&gt;<br>
&gt;&gt; You might also want to cc dri-devel if you resend to get more revi=
ews.<br>
&gt;&gt; I'm also not crazy about having to update the file in chunks, but =
I<br>
&gt;&gt; don't have any better ideas off hand.&nbsp; Maybe an ioctl would b=
e<br>
&gt;&gt; cleaner?<br>
&gt;&gt;<br>
&gt;&gt; Alex<br>
&gt; <br>
&gt; The kernel can only send PAGE_SIZE (4KB) at once, so if the file is<br=
>
&gt; bigger than PAGE_SIZE (max SRM is 5KB) it will send it again until its=
<br>
&gt; finished (unless we increase the page size).<br>
&gt; <br>
&gt; From the user space its just a single command to read/write<br>
&gt; <br>
&gt; &nbsp;&nbsp;&nbsp; save to storage : cat /sys/class/drm/card0/device/h=
dcp_srm &gt; file<br>
&gt; <br>
&gt; &nbsp;&nbsp;&nbsp; load from storage : cat file&gt; /sys/class/drm/car=
d0/device/hdcp_srm<br>
&gt; <br>
<br>
Please also add this info in the patch description or cover letter as<br>
well, including how you iterate for a large SRM. A simple copy-paste<br>
from the shell script should suffice. It's a bit hard to see how this<br>
interface is being used from userspace, especially around the get/set in<br=
>
chunks.<br>
<br>
Harry<br>
<br>
&gt; I will send it to dri-devel after fixing what Harry suggested.<br>
&gt; <br>
&gt; Thanks<br>
&gt; <br>
&gt; Bhawan<br>
&gt; <br>
&gt;&gt;&gt; Harry<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Bhawanpreet Lakha (5):<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp; drm/amd/display: Pass amdgpu_device instead o=
f psp_context<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp; drm/amd/display: update psp interface header<=
br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp; drm/amd/display: Add sysfs interface for set/=
get srm<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp; drm/amd/display: Load srm before enabling HDC=
P<br>
&gt;&gt;&gt;&gt; &nbsp;&nbsp; drm/amd/display: call psp set/get interfaces<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; &nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |&nbs=
p;&nbsp; 2 &#43;-<br>
&gt;&gt;&gt;&gt; &nbsp; .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c&nbsp;&nb=
sp;&nbsp; | 182<br>
&gt;&gt;&gt;&gt; &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&gt;&gt;&gt; &nbsp; .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h&nbsp;&nb=
sp;&nbsp; |&nbsp;&nbsp; 9 &#43;-<br>
&gt;&gt;&gt;&gt; &nbsp; .../drm/amd/display/modules/hdcp/hdcp_psp.h&nbsp;&n=
bsp; |&nbsp; 26 &#43;&#43;-<br>
&gt;&gt;&gt;&gt; &nbsp; 4 files changed, 212 insertions(&#43;), 7 deletions=
(-)<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt; amd-gfx@lists.freedesktop.org<br>
&gt;&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;a=
mp;data=3D02%7C01%7Calexander.deucher%40amd.com%7C6045839ca9f14797ff3a08d79=
f713094%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637153180855191595&amp=
;amp;sdata=3DevmiajEJOkOb2L2GgUxg6JsWadR99PgoTE%2F6cQoBKfs%3D&amp;amp;reser=
ved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calex=
ander.deucher%40amd.com%7C6045839ca9f14797ff3a08d79f713094%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637153180855191595&amp;amp;sdata=3DevmiajEJOkO=
b2L2GgUxg6JsWadR99PgoTE%2F6cQoBKfs%3D&amp;amp;reserved=3D0</a><br>
&gt;&gt;&gt;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C6045839ca9f14797ff3a08d79f713094%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637153180855191595&amp;amp;sdata=3D=
evmiajEJOkOb2L2GgUxg6JsWadR99PgoTE%2F6cQoBKfs%3D&amp;amp;reserved=3D0">http=
s://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freed=
esktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C6045839ca9f14797ff3a08d79f713094%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637153180855191595&amp;amp;sdata=3DevmiajEJOkOb2L2=
GgUxg6JsWadR99PgoTE%2F6cQoBKfs%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH2PR12MB3912DC3EC38450B31ED2FFFBF70C0CH2PR12MB3912namp_--

--===============0946515435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0946515435==--

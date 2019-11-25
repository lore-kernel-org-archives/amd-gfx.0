Return-Path: <SRS0=lTJr=ZR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7F2C432C0
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 23:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C2A20678
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2019 23:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C2A20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C27476E1B6;
	Mon, 25 Nov 2019 23:19:09 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E75A66E1BB
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2019 23:19:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joECd8PWaDkYTMviEuot6tgEbICiRBj78UWAWhvRNEcR6boc9D7LQowCsvxKeQGlZTrGLKq9vZHqauoer+S106n+PIGe1tw/9XaTimC1LMpnIhbAvCCIkQ+yp45N3ygS0DvkNBvAn7+6gnBnbGljm0LxvRclo9MrTlgOJuKVGmHGyI2rD5Qrxa4i9T2rt9Rk5f+kelDvnD/O9ZY2/uhbwrhOtmTTeo4jzti2PPP8DnmzVKnctxzBwSjjW8PipxzCHAumlBuJSIbBv0lmwiJrQ1fyJCbMYjwIzbtNurZUKogiQem9MjLvE+/KjJmexjkbMQY/18Cjsa0Hfs9xnMmYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU6kH15kN9OZICjzcRsGSldgh7PEKzpmDt7/tSF8dFg=;
 b=KdY4KyIfAuiMY2kDNGU6JEcuRYIfHWIh3Hhvv2jYFsne4VwLphJVy79KRGCd63ljS5dZ57XLM0OBj3hMCp1vf9vYEM82dGQ9cya+mhW3TMYKuD0KFNZmnd9bcHyv23nkjhGy7iUIBYLXLcXOLql7nKILrDVHQB8XOGreS0pY/9i8sosiyU3lwBCb8pMc7Fh8AOxBCs9V7ftKXSdmKDT0y2RS14LeOsFDUa3Xr+QqnixBV/wv7cunOO0hrt8EQXPqw1dTMhW99pKokqwLCc4iMwSUbF/hUvB79rWpV6HDnxD9/6E5ob0N6G+kwdn7pZu4SVmOwm5PSdDcqQlsuBKiuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3050.namprd12.prod.outlook.com (20.178.30.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.16; Mon, 25 Nov 2019 23:19:06 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::304d:db58:2aa:d69e%6]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 23:19:06 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: Raise KFD unpinned system memory limit
Thread-Topic: [PATCH 1/1] drm/amdgpu: Raise KFD unpinned system memory limit
Thread-Index: AQHVo9dOhkUH8VyKiUWR50jxCbSEtaecha50
Date: Mon, 25 Nov 2019 23:19:06 +0000
Message-ID:
 <DM6PR12MB277806E387DFC479BDD8AB47F04A0@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191125212819.21392-1-Felix.Kuehling@amd.com>
In-Reply-To: <20191125212819.21392-1-Felix.Kuehling@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2019-11-25T23:19:02.306Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 107a01b3-85cb-4339-4b3f-08d771fdde21
x-ms-traffictypediagnostic: DM6PR12MB3050:|DM6PR12MB3050:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB30509AA52A4D91202BAF7E89F04A0@DM6PR12MB3050.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:451;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(39860400002)(366004)(376002)(136003)(396003)(199004)(189003)(74316002)(26005)(186003)(19627405001)(236005)(81156014)(9686003)(53546011)(5660300002)(6506007)(102836004)(99286004)(33656002)(76116006)(7736002)(7696005)(25786009)(76176011)(606006)(11346002)(91956017)(66446008)(66066001)(66556008)(86362001)(66476007)(64756008)(66946007)(446003)(52536014)(110136005)(71200400001)(71190400001)(105004)(2906002)(316002)(2501003)(14454004)(256004)(8936002)(8676002)(81166006)(6246003)(966005)(6436002)(478600001)(45080400002)(55016002)(6306002)(54896002)(6116002)(3846002)(14444005)(229853002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3050;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0qcyHW8MBtflJEm/piE8W5G26hNo/Bd+a8wLrrCK3+sjaFfk+PO18HY+n23Yq/mIO8wdfYkTX0BxPfQH/BDth08I9RChlomVQASVrO4hBiPPudqmd9OIYSqxEhkwKN6RmqUb77V5Hmnd8GybfrxDpTS32WyTYasWlWbCn8r72KIQNeR8m+kDF+YZXLgBg3j0lacIYofsM62PI1ErMGAIijhoKwahYAC45GS5BykUFg4HZikcABQpS1pia7GFyFZTYLJsKkVg8Qf/RuqOZhn0t0PM3nKTa3OHrjFrmSl6G33aa7qwuKeGSQvLGNW/9XH0uiEwUjyqI5tn8M4qeHKCriXiH0NBLlWFOUI4rj7nITyNl4htYX9Y4H9Ab02ZZ2K475yUStD5S14zPXF8BWSETCtjIPrkjK40QW5nY9jp+2w5vl6w+r3zPu0i/8K6uqd08WTodwCSqMlZCPAJyBKOjglcucNrvtexbv050sAGgpY=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107a01b3-85cb-4339-4b3f-08d771fdde21
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 23:19:06.1574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVWzSx0mPShUDDVgy0x4b3U+Daa0frT47ePWMRXBNw7HdL+6gpsDhMpVZb8P5q50
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3050
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zU6kH15kN9OZICjzcRsGSldgh7PEKzpmDt7/tSF8dFg=;
 b=pE/V/rTB7sUsqR2mT1qDHGxyN0kvBdZ2jq2vj72niErxG18a/gKfF69jZJRSAmc8HeVQ3veTy8szsVtEmBfP74LIZZ3BdCWYpILg6dMtYa7QswQgjlrBo56QLT8W4UY3umnR28oBVCNdmsFiMdy2uGuvsU83BbGVNJCNIbU8GZk=
X-Mailman-Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0857346548=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191125231906.fe-uxjW786UBPEWdhMPzWbVz5T1x69wNhrgYVp7lNhU@z>

--===============0857346548==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB277806E387DFC479BDD8AB47F04A0DM6PR12MB2778namp_"

--_000_DM6PR12MB277806E387DFC479BDD8AB47F04A0DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Yong Zhao <Yong.Zhao@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Felix Ku=
ehling <Felix.Kuehling@amd.com>
Sent: Monday, November 25, 2019 4:28 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdgpu: Raise KFD unpinned system memory limit

Allow KFD applications to use more unpinned system memory through
HMM.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e43a95514b41..b6d1958d514f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -85,7 +85,7 @@ static bool check_if_add_bo_to_vm(struct amdgpu_vm *avm,
 }

 /* Set memory usage limits. Current, limits are
- *  System (TTM + userptr) memory - 3/4th System RAM
+ *  System (TTM + userptr) memory - 15/16th System RAM
  *  TTM memory - 3/8th System RAM
  */
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
@@ -98,7 +98,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
         mem *=3D si.mem_unit;

         spin_lock_init(&kfd_mem_limit.mem_limit_lock);
-       kfd_mem_limit.max_system_mem_limit =3D (mem >> 1) + (mem >> 2);
+       kfd_mem_limit.max_system_mem_limit =3D mem - (mem >> 4);
         kfd_mem_limit.max_ttm_mem_limit =3D (mem >> 1) - (mem >> 3);
         pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
                 (kfd_mem_limit.max_system_mem_limit >> 20),
--
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cyong.zha=
o%40amd.com%7C808d3732d1d74a7cd05208d771ee6f9b%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637103141200385929&amp;sdata=3DyywimvE%2FuidOPQb9IYLZi95Mb=
fnFrW0Swmp11iYi4%2BI%3D&amp;reserved=3D0

--_000_DM6PR12MB277806E387DFC479BDD8AB47F04A0DM6PR12MB2778namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; backgrou=
nd-color: rgb(255, 255, 255); display: inline !important">Reviewed-by: Yong=
 Zhao &lt;Yong.Zhao@amd.com&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Felix Kuehling &lt;Felix.Kueh=
ling@amd.com&gt;<br>
<b>Sent:</b> Monday, November 25, 2019 4:28 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: Raise KFD unpinned system memory li=
mit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Allow KFD applications to use more unpinned system=
 memory through<br>
HMM.<br>
<br>
Signed-off-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 &#43;&#43;--<br>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index e43a95514b41..b6d1958d514f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -85,7 &#43;85,7 @@ static bool check_if_add_bo_to_vm(struct amdgpu_vm *a=
vm,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/* Set memory usage limits. Current, limits are<br>
- *&nbsp; System (TTM &#43; userptr) memory - 3/4th System RAM<br>
&#43; *&nbsp; System (TTM &#43; userptr) memory - 15/16th System RAM<br>
&nbsp; *&nbsp; TTM memory - 3/8th System RAM<br>
&nbsp; */<br>
&nbsp;void amdgpu_amdkfd_gpuvm_init_mem_limits(void)<br>
@@ -98,7 &#43;98,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem *=3D si.mem_unit;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;kfd_me=
m_limit.mem_limit_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.max_system_mem_limit =
=3D (mem &gt;&gt; 1) &#43; (mem &gt;&gt; 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.max_system_mem_limi=
t =3D mem - (mem &gt;&gt; 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.max_ttm_mem_=
limit =3D (mem &gt;&gt; 1) - (mem &gt;&gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Kernel memo=
ry limit %lluM, TTM limit %lluM\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (kfd_mem_limit.max_system_mem_limit &gt;&gt; 20),<br>
-- <br>
2.24.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cyong.zhao%40amd.com%7C808d3732d1d74a7cd05208d771ee6f9b%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637103141200385929&amp;amp;sdata=3DyywimvE%=
2FuidOPQb9IYLZi95MbfnFrW0Swmp11iYi4%2BI%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cyong.zhao%40am=
d.com%7C808d3732d1d74a7cd05208d771ee6f9b%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637103141200385929&amp;amp;sdata=3DyywimvE%2FuidOPQb9IYLZi95Mbfn=
FrW0Swmp11iYi4%2BI%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB277806E387DFC479BDD8AB47F04A0DM6PR12MB2778namp_--

--===============0857346548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0857346548==--

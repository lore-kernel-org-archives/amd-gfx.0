Return-Path: <SRS0=qril=YV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A198CCA9EC0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 15:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AC7208C0
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Oct 2019 15:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AC7208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1551D6E93C;
	Mon, 28 Oct 2019 15:34:09 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700052.outbound.protection.outlook.com [40.107.70.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C75A6E937
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Oct 2019 15:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zmuk1pz062iYOxATeO2/s3KL1e1rINJ/ROPr36PG+U3+HFKU7oN91hXwjg5rP/6Nzp2MM7UijiWtP2MFkNTWV8VQlEe9vP1RTUyau8ZVGrtW628JdLF/k3JepE/mUlwgsnpcgBu5ZJ87ijIBSkN1Ut+6Yy+9Mvzxb87ZXdmI4IPJmGFPsb30ATIsgsi6RbSFxo88nR6qTIPbYs+fUTF62FLOKwFy7fQfK3B+fg0Wl0JRbZmD0uOK9r35Qe89Ghuf9dRCIBaO/YbToIXtdzJ81mAQj3c06ii4Ud5l6k57qqLZpm/QdzUHIxtCeZ5qemHx/2ypp2gT0mLG8eCce9SlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzGcBTijr873pmHmbrQ2zRCk73uX6TordVEMoGPmzZg=;
 b=OMLuKh5nv1Bm0EIkDKKnFTNxH4nlplezt8M4kjtZybhRJuXfP4Chk31uZLu3IQ/8cmO6FUj3QAXxAgK5elZN7TPDFQh+p7NkmQbMIl0UanaueK9vqI1sZLW4sjANxbfs/BCxMbM7nK/IHsUNQXWGR53Wqszpwag5gp3LRSG0V9YO4PsbREBJDm1xwHmjIv1nyIJlDLArqTYvt9s+Go+2s2AdmQ72q4JhF3SyxApZIMX0W+qX6+aCAGTDWL/yoeu8YgE//7mbm/4axk3/5m899NK8MQWkRnW83fAP2LlzKpnKh1n5lefJ98+6jnyS3wSSwX23+cYzobMJxiqK1irE0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from DM6PR12MB2778.namprd12.prod.outlook.com (20.176.114.145) by
 DM6PR12MB3305.namprd12.prod.outlook.com (20.179.106.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 15:34:06 +0000
Received: from DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e]) by DM6PR12MB2778.namprd12.prod.outlook.com
 ([fe80::b411:7d2c:8848:1f6e%7]) with mapi id 15.20.2387.026; Mon, 28 Oct 2019
 15:34:05 +0000
From: "Zhao, Yong" <Yong.Zhao@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Delete unnecessary pr_fmt switch
Thread-Topic: [PATCH] drm/amdkfd: Delete unnecessary pr_fmt switch
Thread-Index: AQHVi3ogYN+NqR6qnka/6FWRBfNMxadwAp6AgAAwgtM=
Date: Mon, 28 Oct 2019 15:34:05 +0000
Message-ID:
 <DM6PR12MB27789F7136560521E8B2DB88F0660@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191025212059.10355-1-Yong.Zhao@amd.com>,
 <CADnq5_Pj_g++EPmmDfgNs0c6CWVfPyL4egfD-ps607bLPQ9fGA@mail.gmail.com>
In-Reply-To: <CADnq5_Pj_g++EPmmDfgNs0c6CWVfPyL4egfD-ps607bLPQ9fGA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [165.204.54.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6b806642-1229-447c-52e1-08d75bbc44a5
x-ms-traffictypediagnostic: DM6PR12MB3305:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DM6PR12MB33056538B3D643B0421C1380F0660@DM6PR12MB3305.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(189003)(199004)(8936002)(25786009)(478600001)(6436002)(316002)(55016002)(9686003)(236005)(3846002)(66946007)(6116002)(11346002)(76116006)(91956017)(1411001)(76176011)(7696005)(64756008)(66556008)(71200400001)(66476007)(99286004)(6246003)(71190400001)(26005)(4326008)(66446008)(66066001)(8676002)(486006)(2906002)(33656002)(966005)(256004)(81156014)(6506007)(14444005)(14454004)(6306002)(81166006)(476003)(86362001)(74316002)(102836004)(5660300002)(606006)(229853002)(105004)(7736002)(446003)(186003)(53546011)(19627405001)(54896002)(6916009)(52536014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3305;
 H:DM6PR12MB2778.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: faDZrTQJ+hsTHNoVO3rKcQUV7GHBpe8WN6VEPT4qKmO4yEwXfFlIt1dsLNVai3+YzTieiSpKRWQIhH+IyOVZVzeRUPIwfvIrW6ak/7p1+EgaLszt570GSDjeeX1jABl+Fk9+44btgNbaJqN8fTzjZdGyZq+7scKIv7C4FvcmPagjMX37ZzwOlZ4Yn9YyhlrpAM/6gbGE6VfPmVWqBNmIOJshCXobwy4Xc1HaEGKQCHAiH47/ExiEqnbNjOpKvufnfllMfHmeYYQ2cA3mraXPZEk4AecAS+ukHtWpL+TqKhy1eoPOuBmKk+qzjEt57fNx0AI5tSNtM8oWB2tllm86y2Ll7uEoKDzxeGsa7LPpZh1Dj3ZRerP4D6yeHYivChzNCsneg1TjLL6kV6hn8wPBl+xbF1nMcK3ovECDRZsB03lMAfMzp34ej2/yMO5quJCGx+58dQL45AECEHvsoLANo4k4M1LpbaH7vMlOkG8HT0E=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b806642-1229-447c-52e1-08d75bbc44a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 15:34:05.6740 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoF/FkKO1Cm/pv7f4VLqmkRkQHe8Z72nqcgGqEtOjUngK76880Wsty/4DDvCKgXd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3305
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzGcBTijr873pmHmbrQ2zRCk73uX6TordVEMoGPmzZg=;
 b=Dkuximz2aNL0MXcSEdaBA0mlYBYYiEqwfOr1FPzdoMHP6KKRzqXB4hcHslBQYe7pOOZyJ3QhGyUV7zKOLsr+KnGNYCT1iaQr6h25/VoazsRjgg6ogpPf+EzC4jQSrdaYrRlWhEgFcf15hvztBURRAlV8lV696tLDxF1jV0d+eVs=
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0382418189=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191028153405.uTLux0gT96Mk6sD_5aW13ewCLnaypmDp_aC5XkKk4kM@z>

--===============0382418189==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB27789F7136560521E8B2DB88F0660DM6PR12MB2778namp_"

--_000_DM6PR12MB27789F7136560521E8B2DB88F0660DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Modified according to the comment and pushed. Thanks!

Regards,
Yong
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Monday, October 28, 2019 8:39 AM
To: Zhao, Yong <Yong.Zhao@amd.com>
Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdkfd: Delete unnecessary pr_fmt switch

On Fri, Oct 25, 2019 at 5:21 PM Zhao, Yong <Yong.Zhao@amd.com> wrote:
>
> Given amdkfd.ko has been merged into amdgpu.ko, this switch is no
> longer useful.
>
> Change-Id: If56b80e086f4ea26f347c70b620b3892afc24ddf
> Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c          | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 4 ----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c  | 3 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c   | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c   | 1 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c   | 3 ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c    | 3 ---
>  7 files changed, 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index d3da9dde4ee1..fa5471c12c34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -19,7 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -

Unrelated whitespace change.

>  #include "amdgpu_amdkfd.h"
>  #include "amd_shared.h"
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index e1fbbebce4fd..b6713e0ed1b2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -19,10 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -
> -#undef pr_fmt
> -#define pr_fmt(fmt) "kfd2kgd: " fmt
> -
>  #include <linux/module.h>
>  #include <linux/fdtable.h>
>  #include <linux/uaccess.h>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 0878f59ec340..61cd707158e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -19,9 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -#undef pr_fmt
> -#define pr_fmt(fmt) "kfd2kgd: " fmt
> -
>  #include <linux/mmu_context.h>
>  #include "amdgpu.h"
>  #include "amdgpu_amdkfd.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index 6e6f0a99ec06..30897b2d9175 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -19,7 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -

Unrelated whitespace change.

>  #include <linux/mmu_context.h>
>
>  #include "amdgpu.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index bfbddedb2380..ede6ab0cbe4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -19,7 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -

Same here.

With those dropped, the patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>  #include <linux/mmu_context.h>
>
>  #include "amdgpu.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/=
gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index c72246f2c08a..47c853ef1051 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -19,9 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -
> -#define pr_fmt(fmt) "kfd2kgd: " fmt
> -
>  #include <linux/mmu_context.h>
>
>  #include "amdgpu.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 1fbe81094b5f..97114e18c022 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -19,9 +19,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -
> -#define pr_fmt(fmt) "kfd2kgd: " fmt
> -
>  #include <linux/dma-buf.h>
>  #include <linux/list.h>
>  #include <linux/pagemap.h>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_DM6PR12MB27789F7136560521E8B2DB88F0660DM6PR12MB2778namp_
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
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Modified according to the comment and pushed. Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Monday, October 28, 2019 8:39 AM<br>
<b>To:</b> Zhao, Yong &lt;Yong.Zhao@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdkfd: Delete unnecessary pr_fmt switch</f=
ont>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Fri, Oct 25, 2019 at 5:21 PM Zhao, Yong &lt;Yon=
g.Zhao@amd.com&gt; wrote:<br>
&gt;<br>
&gt; Given amdkfd.ko has been merged into amdgpu.ko, this switch is no<br>
&gt; longer useful.<br>
&gt;<br>
&gt; Change-Id: If56b80e086f4ea26f347c70b620b3892afc24ddf<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 1 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c | 4 ----<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c&nbsp; | 3 ---=
<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c&nbsp;&nbsp; | =
1 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c&nbsp;&nbsp; | =
1 -<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c&nbsp;&nbsp; | =
3 ---<br>
&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c&nbsp;&nbsp;&nbs=
p; | 3 ---<br>
&gt;&nbsp; 7 files changed, 16 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; index d3da9dde4ee1..fa5471c12c34 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; @@ -19,7 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
<br>
Unrelated whitespace change.<br>
<br>
&gt;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt;&nbsp; #include &quot;amd_shared.h&quot;<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/dri=
vers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; index e1fbbebce4fd..b6713e0ed1b2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c<=
br>
&gt; @@ -19,10 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
&gt; -#undef pr_fmt<br>
&gt; -#define pr_fmt(fmt) &quot;kfd2kgd: &quot; fmt<br>
&gt; -<br>
&gt;&nbsp; #include &lt;linux/module.h&gt;<br>
&gt;&nbsp; #include &lt;linux/fdtable.h&gt;<br>
&gt;&nbsp; #include &lt;linux/uaccess.h&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/driv=
ers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&gt; index 0878f59ec340..61cd707158e4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c<b=
r>
&gt; @@ -19,9 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -#undef pr_fmt<br>
&gt; -#define pr_fmt(fmt) &quot;kfd2kgd: &quot; fmt<br>
&gt; -<br>
&gt;&nbsp; #include &lt;linux/mmu_context.h&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt;&nbsp; #include &quot;amdgpu_amdkfd.h&quot;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&gt; index 6e6f0a99ec06..30897b2d9175 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c<br=
>
&gt; @@ -19,7 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
<br>
Unrelated whitespace change.<br>
<br>
&gt;&nbsp; #include &lt;linux/mmu_context.h&gt;<br>
&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&gt; index bfbddedb2380..ede6ab0cbe4b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c<br=
>
&gt; @@ -19,7 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
<br>
Same here.<br>
<br>
With those dropped, the patch is:<br>
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
<br>
&gt;&nbsp; #include &lt;linux/mmu_context.h&gt;<br>
&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drive=
rs/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; index c72246f2c08a..47c853ef1051 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c<br=
>
&gt; @@ -19,9 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
&gt; -#define pr_fmt(fmt) &quot;kfd2kgd: &quot; fmt<br>
&gt; -<br>
&gt;&nbsp; #include &lt;linux/mmu_context.h&gt;<br>
&gt;<br>
&gt;&nbsp; #include &quot;amdgpu.h&quot;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/driver=
s/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; index 1fbe81094b5f..97114e18c022 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&gt; @@ -19,9 &#43;19,6 @@<br>
&gt;&nbsp;&nbsp; * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE =
OR THE USE OR<br>
&gt;&nbsp;&nbsp; * OTHER DEALINGS IN THE SOFTWARE.<br>
&gt;&nbsp;&nbsp; */<br>
&gt; -<br>
&gt; -#define pr_fmt(fmt) &quot;kfd2kgd: &quot; fmt<br>
&gt; -<br>
&gt;&nbsp; #include &lt;linux/dma-buf.h&gt;<br>
&gt;&nbsp; #include &lt;linux/list.h&gt;<br>
&gt;&nbsp; #include &lt;linux/pagemap.h&gt;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; amd-gfx@lists.freedesktop.org<br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">htt=
ps://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB27789F7136560521E8B2DB88F0660DM6PR12MB2778namp_--

--===============0382418189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0382418189==--

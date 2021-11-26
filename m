Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4A3C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Nov 2021 06:16:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C853E6E575;
	Fri, 26 Nov 2021 06:16:31 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2066.outbound.protection.outlook.com [40.107.102.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4B46E532
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Nov 2021 06:16:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Io+MNYS0Tsz3BQsepLGviLPbF+yOUEb3EI4r7+z0LEcIyBYor0EGd/+F7jWfgJ0WL6qy2FJM9i/STjuvXBMQvFDRharS7XoJio9jAXvlKVJnsOH2rqpM9UYlHmNIxQsVMbWx8w0beQhF0DRnItPWd1uZ6F7KMCkm6DsB3rBq9/VA2ZujLOR8CFYRrED1CaLEPveDDnA3yz6ZPDvDyNKcJlBj/J7Sgs4e/JK+9WxXeyFDZ4Q0sgSDj8SeAn0JExXG3lgg52okVFzlAYDC7258hwsCRTbNQ5D2tH6zeC+ETQOMkJjuJzveewganYlORsfuR0rSNV2SmPcq+n6IB1vaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3BXUyzdMUsShv4eOohcl25E/qE5yJW9VpBHP1F/fnE=;
 b=bCrePcds2sO0ZeN4Zm/MfqbYZMof5xi7ldDffr3U27TyqJ8JNbvUlXLWV6qIDH4AJ9tv2PnUVCft7658LTk3hWiB8JnuSUkVve73RfRZ1/2ullt7NLTN+aSgQFvMTGDMMMSZkrU+EXNG0ksRMLT5ONW8a2QADTgl3LnITN/xFyH8+urZU2FYOe3aP6UnGAVNJpWMTh/mx+f7Q2xFbsNun4JBc8iKPEzPXofHEIz2pwWsypZ3/yffv7Tp4r+M+j+PbIdNMj6Wr0KicWMA5qhPsHkLm+2UPk3YnOvNKOGox/nH9biO73xaRO9JFF6nqLvTl0YxZZ+5C6Zl7J+mGJChlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3BXUyzdMUsShv4eOohcl25E/qE5yJW9VpBHP1F/fnE=;
 b=W7r7CbBf7WJ81xGyPO5Z/SRmtlC9QXfQzGDRf1y/cK8QbFzLki55PRRJjlQj633gPpVI1c2kBEXrpaC8Ppd3zuWEveqX9T8hwuVm1KnD7y5oLapRde3S3e68jb6oMLt2pvNUiX0S/qAs40O7EsboKWj5mVZGvAv+kTnqOQg+n7I=
Received: from CO6PR12MB5473.namprd12.prod.outlook.com (2603:10b6:303:13e::8)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.25; Fri, 26 Nov
 2021 06:16:28 +0000
Received: from CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205]) by CO6PR12MB5473.namprd12.prod.outlook.com
 ([fe80::41ae:ed40:dc40:9205%9]) with mapi id 15.20.4713.026; Fri, 26 Nov 2021
 06:16:28 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Clements, John" <John.Clements@amd.com>
Subject: Re: [PATCH] drm/amdgpu: declare static function to fix compiler
 warning
Thread-Topic: [PATCH] drm/amdgpu: declare static function to fix compiler
 warning
Thread-Index: AQHX4oTaEE9KYX/K6kmbOhk0u5PqZawVVIxo
Date: Fri, 26 Nov 2021 06:16:28 +0000
Message-ID: <CO6PR12MB5473F1EFA3ED7ED17FDB2A7682639@CO6PR12MB5473.namprd12.prod.outlook.com>
References: <20211126051639.25554-1-guchun.chen@amd.com>
In-Reply-To: <20211126051639.25554-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-26T06:16:28.192Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: a6ebf974-67e4-ef40-beb2-24df0ab2ed49
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec2a0f8e-5936-4c34-5ae2-08d9b0a44894
x-ms-traffictypediagnostic: CO6PR12MB5490:
x-microsoft-antispam-prvs: <CO6PR12MB54900EEE0FA707375060557082639@CO6PR12MB5490.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:216;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dlA5bzowbFipfWK4/j+jcGHUifnXcXFlrUaAIAoMQA2q5Xe0FlFrfj4SXKF5lbRtNmFc2kyQ0NCV2yFT1plx4DnfWr3w5EoG7tI7ZjfDSrldqWPlh7ZXPB6/05bMZK+JWkbCuXIBkf7+DLimQyg4+LWBLRR/VnFuWXFMeQd5jK6zihtJaiKWLYU0csfTZH4YvwgMqRIAUvFoj+ORuVI8rI+3Cv74g6/qsNVGvaIKM3nUoL7NvJd8NiOEV5gNamn7D9C9DVwj4GDpIhGVClBefTiAnmMQoSKqZCfiyu8AEbsZWQgulAEw8PEsGslSp8sMuuqSabtga+Eg7yQTWTExNLabH2pYHGulUDJnt112eta5LOtUWnrNsbqMCOncgGIlKI0FN/oiYyUQfqsjqgiyq3Ozf35RYyabYG7XOelC4bg1M8nYIJYhPwFaJBoX7liUaa5kXBWuKtsErXfpNZpsN+k1+H5q/0Z/0Lwt9VkSGvG6C8kgkYGgc4NFnil/lvPxzrUHP1vEgaB298zacfb2Ur6a/kGZyLzxqztlxnjksE8BnRIG66lOVegXwkvVcLK2eijFypwYgb/Poq99kyWt6DNGZjCjpDP5A6BH791SCGAF4a2hb4hNo/GHUxyTmQt6ucFGGjR+SVAidCcFjJQWWxuAZwE3Vh2t7ovQsJSNT8WWkbmPNncD1Lt7JiwFiiYPKSSA5NCMpmC8IqX69ntgLc92mkPW1V/BvfeWv4rXues=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5473.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(66476007)(64756008)(38100700002)(110136005)(19627405001)(33656002)(9686003)(8676002)(66946007)(6636002)(91956017)(66446008)(76116006)(8936002)(86362001)(921005)(55016003)(52536014)(6506007)(66556008)(122000001)(508600001)(71200400001)(316002)(83380400001)(7696005)(2906002)(5660300002)(186003)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?irQsVRTfvyxDIjS4Du6w2DWkxMo0XpZwjt12xvp8fz1SsUhbOpo54HEopG?=
 =?iso-8859-1?Q?cFbK1r5o+pE0p7duMdtBSZEiUftt9dbVWn6ZZ6rJlcGz3l8UuZ3wnp0qo/?=
 =?iso-8859-1?Q?cto4FA9A/KKiVgLFS2Zrbo+/eUAun5Mb8a6sBauvZsvKVxR5YqTUKiidDe?=
 =?iso-8859-1?Q?kprVoVHXD8NYR/86PA8poqvAMF+uD21RPcZq1491YfZWXpdUcr8dvZvpy8?=
 =?iso-8859-1?Q?ME9+z2en4cUvaz1xLE5YAPBaJiyRALYX3X0J6VuGIGhFGeHXtGJJ9BzyKS?=
 =?iso-8859-1?Q?Ei5dQIXWsGU1nlJB302IqiU2/3F/j9DqukrV+e2Ee7f7OmHKgkXopSdgVJ?=
 =?iso-8859-1?Q?h6ntP9j/2T0RZh1vhkjumpxc7AkXSQgjatsOz6Yo59vb87Re0EPBttwo8k?=
 =?iso-8859-1?Q?sMy/a/Sy+LusaoKFC5YX7zGQkaEyurRuBGyX0ywjAQa9ksJOm3jlXPX5wM?=
 =?iso-8859-1?Q?1EE6P3U9+SWlS2Cpk2Q7fNMSaTokPnOwc5s5rFGOfu7gzALXoAs91zdxKF?=
 =?iso-8859-1?Q?STfaQFJUnVjmEg3P1KKxOf/pateN8YA1K3u0ti0qjGn2JtKBwjw3T7kGxA?=
 =?iso-8859-1?Q?RIUdVEhaHGA0f2LzW8yKu22mjnJ0bdHxxPU+/j6Dtj0nNx75YTNcJE0uEY?=
 =?iso-8859-1?Q?+APFZA5NjJUNQUpnh3fWRCBDDvj9reD6dnkKns4GuJkreCFlEf0oUXpO22?=
 =?iso-8859-1?Q?NVXjGCCI+t/2fpY1e6+E538ZeszbyM4lX0CGWx10msGQPHeP8oMXd0HXqh?=
 =?iso-8859-1?Q?9kj3P5QPshB7b+CGbnR0pr7uIL348Z07XFOOgnrCF6FYCpIiLlQgZou1yO?=
 =?iso-8859-1?Q?OmzmkUvFkIYwXl0sEB/VaOBzKv3H6ThHjqkcAau5Lm9gjg/4vp6BPllUqJ?=
 =?iso-8859-1?Q?X4Bdk21iuII6Y5wo4uH1OBn0+TJ/SWQ6K966FN1EhfuE89x4qorxq2Vc0G?=
 =?iso-8859-1?Q?oNxjfg+ISRV4kl1+PJFFt+deGCaXpcy5PgQ98h7ly2PFagW6z1jPDnE2Bt?=
 =?iso-8859-1?Q?By5knKe9ho3JXIX51Tk1qcvRcSUWogpihQN1q1CTfNYG3fhSZ/31FosOSu?=
 =?iso-8859-1?Q?2uYAKWzIxE0bcMlzdxSM/gU3v+VCZrQbOjuK3bn7zMyjVO/VOQDyMSntCG?=
 =?iso-8859-1?Q?Mo0uMg6UPTezozMtm9rK9YaeU+FNIJ/GU4SbpkJKOv/a+KHE8/pUimq121?=
 =?iso-8859-1?Q?0T6HzP3QRhS4wHwd/fEflf96o8FAZmuvtUg8S9RY/bpUcfXwsuxLdZmkvd?=
 =?iso-8859-1?Q?VpdzvnWc7OLbzXWu2/OMwMS5cDTw7QhBwhtwlTPXe6wa/1UZz6z26AJzjC?=
 =?iso-8859-1?Q?TQ+gPKWxIkFnm3qOMgXm8lVrr0bqs+E0LLpBh+9HVh7syvr+W/tYLETb7D?=
 =?iso-8859-1?Q?YjcH5BnWv5Gc+MHVmy8RSlHm5stqZlPCaIt3af/XXzq1NDFSRIl/6IBdFk?=
 =?iso-8859-1?Q?aj5pEMLFHaS6HM65zvoQ4v930YASwwjxaWyiNmrDycleS6t7bix56MnYQB?=
 =?iso-8859-1?Q?eb6Aj58a/3Hc0opF+AaIVHH4SjsBYeNZJkD4YPj/9HsO9iqyJ7e4ChqUGc?=
 =?iso-8859-1?Q?pUCUzujOy1Y9QKNXhjmec2a0LXLKM/MuV5PufCWodjKRM4lY219h6Fx4un?=
 =?iso-8859-1?Q?c2hneDBD20zNf2zkGEWIMl3xDyeKT8xM+Zme1lnbLnv9JNv7SukgsSypzc?=
 =?iso-8859-1?Q?SXQKWAN4M04O569DdkE=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CO6PR12MB5473F1EFA3ED7ED17FDB2A7682639CO6PR12MB5473namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec2a0f8e-5936-4c34-5ae2-08d9b0a44894
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 06:16:28.6043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ssF6kR30dGxSNPBzim4il9km+RjlPyGWPh2tvxWsnZ6AAajf8iSzzfARR5YzP7Vy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
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

--_000_CO6PR12MB5473F1EFA3ED7ED17FDB2A7682639CO6PR12MB5473namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Reviewed-by: Kevin Wang <kevinyang.wang@amd.com>

It is reasonable to modify it to a static function, which can be matched wi=
th function of acquire_psp_cmd_buf() .

Best Regards,
Kevin
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Guchun C=
hen <guchun.chen@amd.com>
Sent: Friday, November 26, 2021 1:16 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deucher,=
 Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig=
@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; Clements, John <John.Clements@=
amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdgpu: declare static function to fix compiler warnin=
g

>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:503:6: warning: no previous prot=
otype for function 'release_psp_cmd_buf' [-Wmissing-prototypes]
   void release_psp_cmd_buf(struct psp_context *psp)
        ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:503:1: note: declare 'static' if=
 the function is not intended to be used outside of this translation unit
   void release_psp_cmd_buf(struct psp_context *psp)
   ^
   static
   1 warning generated.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index c641f84649d6..b48d68d30d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -518,7 +518,7 @@ static struct psp_gfx_cmd_resp *acquire_psp_cmd_buf(str=
uct psp_context *psp)
         return cmd;
 }

-void release_psp_cmd_buf(struct psp_context *psp)
+static void release_psp_cmd_buf(struct psp_context *psp)
 {
         mutex_unlock(&psp->mutex);
 }
--
2.17.1


--_000_CO6PR12MB5473F1EFA3ED7ED17FDB2A7682639CO6PR12MB5473namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: &quot;Segoe UI&quot;, &quo=
t;Segoe UI Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, =
BlinkMacSystemFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-si=
ze: 12pt; background-color: rgba(0, 0, 0, 0);">Reviewed-by: Kevin Wang &lt;=
kevinyang.wang@amd.com&gt;</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;"><br>
</span></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;"></span></div>
<div><span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (=
West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFo=
nt, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color:=
 rgb(0, 0, 0); background-color: rgba(0, 0, 0, 0);">It is reasonable to mod=
ify
 it to a static function, which can be matched with function of </span><spa=
n style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West Euro=
pean)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Robot=
o, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color: rgb(0, 0=
, 0); background-color: rgba(0, 0, 0, 0);"><i>acquire_psp_cmd_buf()
 .</i></span><br>
</div>
<span></span>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0); background-color: rgba(0, 0, 0, 0);">Best Regards,</span></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<span style=3D"font-family: &quot;Segoe UI&quot;, &quot;Segoe UI Web (West =
European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, R=
oboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 12pt; color: rgb(=
0, 0, 0); background-color: rgba(0, 0, 0, 0);">Kevin</span></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Guchun Chen &lt;guchun.chen@a=
md.com&gt;<br>
<b>Sent:</b> Friday, November 26, 2021 1:16 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;; Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Christia=
n &lt;Christian.Koenig@amd.com&gt;; Pan, Xinhui &lt;Xinhui.Pan@amd.com&gt;;=
 Clements, John &lt;John.Clements@amd.com&gt;<br>
<b>Cc:</b> Chen, Guchun &lt;Guchun.Chen@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: declare static function to fix compiler=
 warning</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">&gt;&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:5=
03:6: warning: no previous prototype for function 'release_psp_cmd_buf' [-W=
missing-prototypes]<br>
&nbsp;&nbsp; void release_psp_cmd_buf(struct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^<br>
&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:503:1: note: declare '=
static' if the function is not intended to be used outside of this translat=
ion unit<br>
&nbsp;&nbsp; void release_psp_cmd_buf(struct psp_context *psp)<br>
&nbsp;&nbsp; ^<br>
&nbsp;&nbsp; static<br>
&nbsp;&nbsp; 1 warning generated.<br>
<br>
Reported-by: kernel test robot &lt;lkp@intel.com&gt;<br>
Signed-off-by: Guchun Chen &lt;guchun.chen@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index c641f84649d6..b48d68d30d80 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -518,7 +518,7 @@ static struct psp_gfx_cmd_resp *acquire_psp_cmd_buf(str=
uct psp_context *psp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return cmd;<br>
&nbsp;}<br>
&nbsp;<br>
-void release_psp_cmd_buf(struct psp_context *psp)<br>
+static void release_psp_cmd_buf(struct psp_context *psp)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;psp-&gt;=
mutex);<br>
&nbsp;}<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CO6PR12MB5473F1EFA3ED7ED17FDB2A7682639CO6PR12MB5473namp_--

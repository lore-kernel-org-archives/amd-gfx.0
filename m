Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688A4C7EE2F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 18:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3A4810E055;
	Mon, 12 Jun 2023 18:14:52 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35F310E055
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 18:14:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL6r1JLqsFi6CnGooHd375/vaxgwGWwyXHUGwJQBH0awKTTUkULfK2mEAT0eRZ/EhCC65kT0MI+bsNwtov4QzCX7ftKg/pmh69mEIVPnyOnw41/nAsz4BaJ9OWiva/7dUn16m0U4LCQ8In96u4ZsvpEqFMcKwx1mpwUcfeNtHGsBeBJlnfoTnjHVcNSq+qb1Bmnax2a/glmDsE1xoKQGi3H9XW978KS/R/jC199Z+7BgyGkHowZLRqJLQCnsNv8ptjyvGlR/idBf8hC9U1ujT2IGcjZXjHb/QF8eoTrodbnJWPNZjYY7gfnvt9jENDM8i56rVkmxzziYfZtGSok3vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0kKO1RK9UuhTWLaJfA9CE7+LbVhRQ4hX6QKaNQklOk=;
 b=QgCbhAP7Otw0J3lKX5i3Gjt4sHgzRaEpGQ+MBwWboaahPx+WXugqefaDWFpH77TK4qd6MECeKTFh6f7tOhP6vOwNRPdcUApC1bX8YcYpQFg/Wb5rDMSbg4+BQ+h2w2RKxWxwn/TuH9FFhu9kl2tlzgxe1MkqXHpr7YjE2tQmNPEbHtJ0PXjHIWz2rdYxkw50ocTVE90WkeSQjHM4VyUSBGrzYVc26avwcFc56SA8+s8HjcXwBd6fSX0j//0HVAHfyI4X+8BSooEe6M0sTIjxT713eSSNFg2/2N1KqqLzk9+AsTx+QiXT+ZHIZqoQdLAWkFZry/poppdsTXQAH1WmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0kKO1RK9UuhTWLaJfA9CE7+LbVhRQ4hX6QKaNQklOk=;
 b=FjSEov5JpkJQTiz5P6NHA0eQiX4O37XWKWjxQxjO1mxYKWU1MCpxqfxmIXescSZ67e1rJ2DMN36AWedm+H88/EAw9JMbWJVU89jyRZ82401vIucCJpJ1t463mXGnfkK4fVsfGf80Hreuw7E22m6X6ivsCnsZW4eJgnLTSQhvsAM=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Mon, 12 Jun
 2023 18:14:48 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::e02a:b0f7:e051:10cd%4]) with mapi id 15.20.6455.045; Mon, 12 Jun 2023
 18:14:47 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>, "Zhuo, Qingqing
 (Lillian)" <Qingqing.Zhuo@amd.com>, "Chalmers, Wesley"
 <Wesley.Chalmers@amd.com>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Topic: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit
Thread-Index: AQHZmE+p2kFzkjFxL0CbkqT2G2DnrK9+CffjgAGIgQCAAAYZqoABX4oAgAABSOeAAA7dgIAGeI05
Date: Mon, 12 Jun 2023 18:14:47 +0000
Message-ID: <CH0PR12MB5284E2DAE880B3C1059076648B54A@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <bc662b83-f117-2f61-c580-086c3f404086@daenzer.net>
 <ec919f31-2f33-f085-dfdd-25360b5e082c@daenzer.net>
 <CH0PR12MB528496B026471110065187488B52A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <df1dde7c-f789-97eb-5b67-266bbb95c1e1@daenzer.net>
 <CH0PR12MB5284C88ABA0C45CD177F9C5B8B53A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <f7c2a548-3154-c163-bf73-19a8c2939447@daenzer.net>
 <CH0PR12MB5284FFF8F26F8ACD7838BB6B8B50A@CH0PR12MB5284.namprd12.prod.outlook.com>
 <579a46c1-d33a-dfb6-25e7-b657f0be1765@daenzer.net>
In-Reply-To: <579a46c1-d33a-dfb6-25e7-b657f0be1765@daenzer.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-12T18:14:46.569Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|SJ1PR12MB6340:EE_
x-ms-office365-filtering-correlation-id: 0d1a7f04-5c52-4eb2-cdbe-08db6b70e803
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1rUJx53gDWrsrMf/JpXZ5KRwChHOeaAPvNgyDtc7FR2iiObHg/ycQpqZoxbUkTxjeN36khqIPAXXMx8AiKOo+BcXzKUW0AK8NS1yS/toIayk8jQIRF07dv0TCsRqmlvTesY/phWu4MGo9Sdqb1FTviQOue/T/sMHIcWBm5RFZUnWsaN8Bn8UfoTlrnzRJ1CHlIXWuDeigExqnS5ibW3ePES77JlvXv63C19OTSvv295o8EoQyaZLN7+1rDWd/7QaKvy6QbkL8FUZHAnbIM8x/OstzL+1zXRlal4YhlvkuPlVQrhmQxWsAQ4SH1fdx/Okhd0WE32pTwbnIc+lpCWMc/9MvJ7jW6V1ADBYuDAwCBLh2rQSrR6xihs2pQoJ53QmLY0TaEAN+3lb5AcmRO51B+mytE5RWia4TSGfZXoGAlQYBlYA0aLT3sUUSF1RxxmfUucOc/+rwEdEkWASVWWGau81mMWJJpQvlqXHJE1JBjpEIfvfHm/L2dNSw8V5vOqFMFdnp4yA4UGgfGRCPsutHC0WiHlbAQU+jxl+iNAezvC/b1zJzeOYe+lyLQZhLfi6rbIgU6ZvX/0dpIKazaQtCqizXpnFy0no3d5esyBLSWw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(366004)(136003)(39860400002)(346002)(451199021)(66574015)(966005)(99936003)(54906003)(478600001)(55016003)(33656002)(8676002)(8936002)(38100700002)(316002)(91956017)(41300700001)(66946007)(76116006)(66476007)(66446008)(166002)(52536014)(66556008)(64756008)(6636002)(38070700005)(5660300002)(122000001)(86362001)(4326008)(7696005)(2906002)(71200400001)(110136005)(6506007)(9686003)(26005)(53546011)(19627405001)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3wLWo2VRL9Dc8B87GLf1toGieNfDvoYcyMSL3uRDBNTy068ZqJ/tgyx6fo?=
 =?iso-8859-1?Q?DXAglhDn7fPSS6OvO+pzU2k352weizvNUVQAzSBJPRHCB11uuUKr2Kq+5U?=
 =?iso-8859-1?Q?605B0N4XV06Dy+j1xC926yJcCTkyW1vf3qluypzkq5OyIhKYdqlHTaYvum?=
 =?iso-8859-1?Q?7VP4W8IAxeEbmCvblR4jUgmL7nkfY4dge3HT6YWY5ifl82+ohZ9wzTYDnO?=
 =?iso-8859-1?Q?aKp7xaPagZFu0jZANU3/i7mXl7qd4TQgqGVz0HLJHQJjJEIlM8jXv4vzy+?=
 =?iso-8859-1?Q?e/PwOKUfYjfBwI/JUr023kYrjI4cU4kYsH0XQnb1dgURjJ0zGbTz6+LOLE?=
 =?iso-8859-1?Q?W/QI7FxVuQAsKr3FOKv8uVGNom2f1Je6Teb+4HZkoa1RD5lT/Rmnz1kdJ8?=
 =?iso-8859-1?Q?M5Z68yrEK3Ff08qh4jNuf/TjqbyKXdXIxDBHyqyC6Q/wQgXR0BPfJg5a/d?=
 =?iso-8859-1?Q?H29KYj8mKTvCIBK0m8wowyIjuxMaavTSSK8p1b94kj4dsVS9p8xdiUM27M?=
 =?iso-8859-1?Q?k5ptmL8WFgrKVIAucVAGFFIwXSvFjNLp+e2tAqME611Yj6ASG9nX7hbW9p?=
 =?iso-8859-1?Q?XwmvhtB1QomS7FTTfJOj8xUSVEqn6tqg66oSJ6PqJGaA9WrmO50ZhCn0Hh?=
 =?iso-8859-1?Q?vTmA/3P40jN4CK3+y/DqLzT9fScnMwqNiGRI2jDdvMWLssBhADGcL2xUG+?=
 =?iso-8859-1?Q?IEEtqS54+p+2HkHVjzBvpIqvEw7dW3Nkei76EfKTS3Sn5UtKjgFje/R4K8?=
 =?iso-8859-1?Q?WAWb7puBqhoqQFezy+PqPq2AaPl1asSOMZpGmMs3bECVyclKkt1jD890lC?=
 =?iso-8859-1?Q?ZqpFj+vBoWCTurbrV5KH+ng+rZ49oDUqaQYKLL5sYg7QvHRMUUFclAA6Tu?=
 =?iso-8859-1?Q?E10ZwXWpC7xTvIZy7ghvZQPpIHmqJEEg6zsfEP7067Zl1pgfKE8VyVWYJV?=
 =?iso-8859-1?Q?O9W6MfVitvoHv0WgNUzd1OySZG0fTwvjhcFCNGlPk4O+h6Gqf7ZSqr0bwU?=
 =?iso-8859-1?Q?FUb95Cs6fgUZMMjTrvGXTvdbC+lMpfOZMpYKn1YGVtnu5uRCWTKiarExlD?=
 =?iso-8859-1?Q?Oaoy/JwEgQCy1P135+kxCSxwdAIYxZIvg1yJ644Gn0xaWMgwgP2gBKvrmZ?=
 =?iso-8859-1?Q?0FkA+8be9Kc/ZZbqzP1dR0Hs6RoHP658MfJvyhOxRRdTyubmmrb/1fwcW3?=
 =?iso-8859-1?Q?awB23I4AJYYs4AIIkezDOMSdjvz44c95PZq2+vYAyiyelI/MnUML6vE5na?=
 =?iso-8859-1?Q?kfszyMMNLrf3OX/TpJBLu7Kw3Nn67uxC3aEDyRmz+az6Wo9bXZqA7y6mJS?=
 =?iso-8859-1?Q?tMZhqUvAw2N52LS6QOS3vbYWYHKxmEjo6mx9tnVIrWzadLX8UvsgVTvole?=
 =?iso-8859-1?Q?zavU9W09lD8p4r0+sWm1+UIKAPN8RIfoBzPPydJMZz8KHxhNoy61362+Et?=
 =?iso-8859-1?Q?+/JUvhXuCLaLOOxng4ED6/4MX+A+qwXRXSvw91VnlegP/xAbqAU0TVN0VJ?=
 =?iso-8859-1?Q?u5G1UYPitOw931SEG5RB2CVVsMlS4+DXVNXou1RS+0hWGl9s3wiXKqQBk/?=
 =?iso-8859-1?Q?XwLvc59aYFg7dP6rfR6R3SGt/f28FBYZY8LK49/DQY1INj2/6pT+mIwRoO?=
 =?iso-8859-1?Q?I6VsuMLQfPRUo=3D?=
Content-Type: multipart/mixed;
 boundary="_004_CH0PR12MB5284E2DAE880B3C1059076648B54ACH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1a7f04-5c52-4eb2-cdbe-08db6b70e803
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 18:14:47.5963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nKG3Shu0j3Psr/coRs4JQ5Ma/YgoxSOBVLe54Sr7nOkVmH0pBXrJKjzB+ahR7glvgrLKvICX1RT2y10m0qNbIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha, 
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_004_CH0PR12MB5284E2DAE880B3C1059076648B54ACH0PR12MB5284namp_
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB5284E2DAE880B3C1059076648B54ACH0PR12MB5284namp_"

--_000_CH0PR12MB5284E2DAE880B3C1059076648B54ACH0PR12MB5284namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[Public]

Hi Michel,

I want to double check if we're identifying the correct monitor for applyin=
g the workaround. Could you please try the attached patch and let me know t=
he panel id ?

--

Regards,
Jay
________________________________
From: Michel D=E4nzer <michel@daenzer.net>
Sent: Thursday, June 8, 2023 11:18 AM
To: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Zhuo, Qingqing (Lillian) =
<Qingqing.Zhuo@amd.com>; Chalmers, Wesley <Wesley.Chalmers@amd.com>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Siqueira, Rodrig=
o <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.com>; amd-gfx@lists.f=
reedesktop.org <amd-gfx@lists.freedesktop.org>; Chiu, Solomon <Solomon.Chiu=
@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.=
Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, Pa=
vle <Pavle.Kotarac@amd.com>
Subject: Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe commit

On 6/8/23 16:31, Pillai, Aurabindo wrote:
>
> Thanks Michel,
>
> I reached out to windows driver team, and they have a monitor specific qu=
irk to disable FAMS on this model. I suspect the issue is only present on c=
ertain fw revisions on the monitor which is why we cant see your issue.
>
> Unfortunately, having the patches in question reverted causes hangs with =
3 monitor setups. So I will push that monitor specific quirk and bring back=
 the reverted patches.

Sounds good, thanks.


--
Earthling Michel D=E4nzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer


--_000_CH0PR12MB5284E2DAE880B3C1059076648B54ACH0PR12MB5284namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#008000;margin:15pt;font=
-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Hi Michel,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I want to double check if we're identifying the correct monitor for applyin=
g the workaround. Could you please try the attached patch and let me know t=
he panel id ?<br>
</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Michel D=E4nzer &lt;m=
ichel@daenzer.net&gt;<br>
<b>Sent:</b> Thursday, June 8, 2023 11:18 AM<br>
<b>To:</b> Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Zhuo, Qingqi=
ng (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; Chalmers, Wesley &lt;Wesley.Cha=
lmers@amd.com&gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun pen=
g (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Siqueira@amd.com&gt;; Li, Roman &lt;=
Roman.Li@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freed=
esktop.org&gt;;
 Chiu, Solomon &lt;Solomon.Chiu@amd.com&gt;; Lin, Wayne &lt;Wayne.Lin@amd.c=
om&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; Gutierrez, Ag=
ustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle &lt;Pavle.Kotarac@a=
md.com&gt;<br>
<b>Subject:</b> Re: [PATCH 10/66] drm/amd/display: Do not set drr on pipe c=
ommit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 6/8/23 16:31, Pillai, Aurabindo wrote:<br>
&gt; <br>
&gt; Thanks Michel,<br>
&gt; <br>
&gt; I reached out to windows driver team, and they have a monitor specific=
 quirk to disable FAMS on this model. I suspect the issue is only present o=
n certain fw revisions on the monitor which is why we cant see your issue.<=
br>
&gt; <br>
&gt; Unfortunately, having the patches in question reverted causes hangs wi=
th 3 monitor setups. So I will push that monitor specific quirk and bring b=
ack the reverted patches.<br>
<br>
Sounds good, thanks.<br>
<br>
<br>
-- <br>
Earthling Michel D=E4nzer&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href=3D"https://redhat.com=
">
https://redhat.com</a><br>
Libre software enthusiast&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; |&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mesa and Xwayland de=
veloper<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284E2DAE880B3C1059076648B54ACH0PR12MB5284namp_--

--_004_CH0PR12MB5284E2DAE880B3C1059076648B54ACH0PR12MB5284namp_
Content-Type: text/x-patch;
	name="0001-drm-amd-display-Add-monitor-specific-edid-quirk.patch"
Content-Description:  0001-drm-amd-display-Add-monitor-specific-edid-quirk.patch
Content-Disposition: attachment;
	filename="0001-drm-amd-display-Add-monitor-specific-edid-quirk.patch";
	size=1922; creation-date="Mon, 12 Jun 2023 18:11:43 GMT";
	modification-date="Mon, 12 Jun 2023 18:12:11 GMT"
Content-Transfer-Encoding: base64

RnJvbSAzZGZjYjVlNjBlYzlmYzllYzZjNTczMjMxZTViNmFhNGVkY2EyZWQ2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBdXJhYmluZG8gUGlsbGFpIDxhdXJhYmluZG8ucGlsbGFpQGFt
ZC5jb20+CkRhdGU6IE1vbiwgMTIgSnVuIDIwMjMgMTI6NDQ6MDAgLTA0MDAKU3ViamVjdDogW1BB
VENIXSBkcm0vYW1kL2Rpc3BsYXk6IEFkZCBtb25pdG9yIHNwZWNpZmljIGVkaWQgcXVpcmsKCkRp
c2FibGUgRkFNUyBvbiBhIFNhbXN1bmcgT2R5c3NleSBHOSBtb25pdG9yLiBFeHBlcmltZW50cyBz
aG93IHRoYXQgdGhpcwptb25pdG9yIGRvZXMgbm90IHdvcmsgd2VsbCB1bmRlciBzb21lIHVzZSBj
YXNlcywgYW5kIGlzIGxpa2VseQppbXBsZW1lbnRhdGlvbiBzcGVjaWZpYyBidWcgb24gc29tZSBy
ZXZpc2lvbnMgb2YgdGhlIGRldmljZS4KClNpZ25lZC1vZmYtYnk6IEF1cmFiaW5kbyBQaWxsYWkg
PGF1cmFiaW5kby5waWxsYWlAYW1kLmNvbT4KLS0tCiAuLi4vYW1kL2Rpc3BsYXkvYW1kZ3B1X2Rt
L2FtZGdwdV9kbV9oZWxwZXJzLmMgfCAyNCArKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgMjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYyBiL2RyaXZlcnMvZ3B1L2RybS9h
bWQvZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYwppbmRleCBjZDIwY2ZjMDQ5
OTYuLmU3ZTU0NTY2NTAwNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5
L2FtZGdwdV9kbS9hbWRncHVfZG1faGVscGVycy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
ZGlzcGxheS9hbWRncHVfZG0vYW1kZ3B1X2RtX2hlbHBlcnMuYwpAQCAtNDQsNiArNDQsMjggQEAK
ICNpbmNsdWRlICJkbV9oZWxwZXJzLmgiCiAjaW5jbHVkZSAiZGRjX3NlcnZpY2VfdHlwZXMuaCIK
IAorc3RhdGljIHUzMiBlZGlkX2V4dHJhY3RfcGFuZWxfaWQoc3RydWN0IGVkaWQgKmVkaWQpCit7
CisJcmV0dXJuICh1MzIpZWRpZC0+bWZnX2lkWzBdIDw8IDI0ICAgfAorCSAgICAgICAodTMyKWVk
aWQtPm1mZ19pZFsxXSA8PCAxNiAgIHwKKwkgICAgICAgKHUzMilFRElEX1BST0RVQ1RfSUQoZWRp
ZCk7Cit9CisKK3N0YXRpYyB2b2lkIGFwcGx5X2VkaWRfcXVpcmtzKHN0cnVjdCBlZGlkICplZGlk
LCBzdHJ1Y3QgZGNfZWRpZF9jYXBzICplZGlkX2NhcHMpIHsKKwl1aW50MzJfdCBwYW5lbF9pZCA9
IGVkaWRfZXh0cmFjdF9wYW5lbF9pZChlZGlkKTsKKworCXN3aXRjaCAocGFuZWxfaWQpIHsKKwlj
YXNlIGRybV9lZGlkX2VuY29kZV9wYW5lbF9pZCgnUycsICdBJywgJ00nLCAweDBFNUUpOgorCWNh
c2UgZHJtX2VkaWRfZW5jb2RlX3BhbmVsX2lkKCdTJywgJ0EnLCAnTScsIDB4NzA1Myk6CisJCXBy
X2VycigiIyMjIEFwcGx5aW5nIGFueSBlZGlkIHF1aXJrIGZvciBwYW5lbCAleFxuIiwgcGFuZWxf
aWQpOworCQllZGlkX2NhcHMtPnBhbmVsX3BhdGNoLmRpc2FibGVfZmFtcyA9IHRydWU7CisJCWJy
ZWFrOworCWRlZmF1bHQ6CisJCXByX2VycigiIyMjIE5vdCBhcHBseWluZyBhbnkgZWRpZCBxdWly
ayBmb3IgcGFuZWwgJXhcbiIsIHBhbmVsX2lkKTsKKwkJcmV0dXJuOworCX0KK30KKwogLyogZG1f
aGVscGVyc19wYXJzZV9lZGlkX2NhcHMKICAqCiAgKiBQYXJzZSBlZGlkIGNhcHMKQEAgLTExNSw2
ICsxMzcsOCBAQCBlbnVtIGRjX2VkaWRfc3RhdHVzIGRtX2hlbHBlcnNfcGFyc2VfZWRpZF9jYXBz
KAogCWVsc2UKIAkJZWRpZF9jYXBzLT5zcGVha2VyX2ZsYWdzID0gREVGQVVMVF9TUEVBS0VSX0xP
Q0FUSU9OOwogCisJYXBwbHlfZWRpZF9xdWlya3MoZWRpZF9idWYsIGVkaWRfY2Fwcyk7CisKIAlr
ZnJlZShzYWRzKTsKIAlrZnJlZShzYWRiKTsKIAotLSAKMi40MC4xCgo=

--_004_CH0PR12MB5284E2DAE880B3C1059076648B54ACH0PR12MB5284namp_--

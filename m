Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3110C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 18:44:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F91B10E6BF;
	Fri,  4 Feb 2022 18:44:58 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2048.outbound.protection.outlook.com [40.107.96.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2DF810E6BF
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 18:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJiB0vQA1hvx8J6+GC0WT14BUTfGCKDDfIbU9QxORhHQH36ltU4MhJjiec5JppyVQidA5HGn2l5srjBcRQ5e8DhDJbqX9+ZfkrS2sUQN7gvUQbxpPWR+5ui8fUUSp1lY2659EAAk7lSex7B++pmIrXJOS96RvjCTdpjtw66xwFimzfzC4zx2FcrVE2zjEkf5IuhgSFqB9dDQbG5qYYi2Qa3f9fx3WQWzN8o1boJNdJ+EMFpbd3cqA/dWpKRm08RK/zLlf20k6/WFIGs8kVtH0GZKGBXqchjvpaoiN+tLFk0uxceVHZojw7jOiT8O4b7g5oKEMjypEaJoJ0CYlJ0tUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hFtnOiVqLBHdRddmkvxWHWMseWhFhVTWM3ZTVPAvqU=;
 b=XZgT30Iu8NH4JXnUeBeE3zEhrosh7QTUHd5s4zmhWgrGM2hVebwatWmblkQxbjzeXnYCcnyjcdLIir/H7WtY11g1va6ksAGOAr89CMVWKbmkqOHg6FTSPwIDfUFWU0UECHS0Oonpe97e0m04TanrI34RfNighOdQOYM3L83W0ELJdHpORm/6NdT8V7CNWlZH2MSAlE5bTH4UthUfFO0XWkr/YUREAHIWpoe/+qcszo1CkW4QIkJ6Y4WYEbxwdOPOGDM+68JJ5JKx5+YqFHR1U0JRM7h9zPhwD9tfu1fYLeikvRqXUqLhy78zxpUKi5D6cJHY6oCNmHlp+esq7sWrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hFtnOiVqLBHdRddmkvxWHWMseWhFhVTWM3ZTVPAvqU=;
 b=Sp5ZGLCkfIu7WmZ6SQvgZiFba/tBJ0+WWBgGKJEO4PRKeRS7dGUmwLcpaLsL9FSgn9f3p1LI/cCWxHcJYtXFRgPDoEZ4+WkPwUrsBW2z9Bt6srFIg/ZZXLTXr/tUKcqiVNBGaQQ60jdlg8hJKX121CfqQjtbWeU6/Up63k0qhA4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DM6PR12MB4862.namprd12.prod.outlook.com (2603:10b6:5:1b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:44:52 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.014; Fri, 4 Feb 2022
 18:44:52 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>, "Lazar, Lijo"
 <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Topic: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
Thread-Index: AQHYDwZgmiM6tPfbKk6pcwThDQVivaxumGUAgBUU44CAAANYgIAAAlUAgAAA3ACAAAFugIAAATOAgAABfoCAAADyAIAAAKOAgAAVUsGAAAEddA==
Date: Fri, 4 Feb 2022 18:44:52 +0000
Message-ID: <BL1PR12MB514487E169A1614431BCD1F7F7299@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <146b13d5-f883-6aff-2f3a-0570d9041bf3@amd.com>
 <a0693436-619c-efa1-b3f1-2fca6377e2fe@amd.com>
 <817df2c3-e7af-92cb-53f8-8bc70b69b988@amd.com>
 <BYAPR12MB46149A07EB030CB27FDA8B1397299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <8bada9e4-d6d5-e11a-45fe-aea7615f3356@amd.com>
 <BYAPR12MB4614325D69EACA459547E4F597299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <77fd42df-be70-18bd-ebb8-503214ef6af8@amd.com>
 <BYAPR12MB461419D8152EBBD70BB9BAFC97299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <c28e3fad-29ac-a326-30c3-4f4de0001e47@amd.com>
 <BYAPR12MB4614628DE8E6D39EE53307DF97299@BYAPR12MB4614.namprd12.prod.outlook.com>
 <b885ef98-3ff3-92b3-c238-041a0f5ab2a6@amd.com>
 <BL1PR12MB5144C96658B5B9F3058FCB1AF7299@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5144C96658B5B9F3058FCB1AF7299@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=True;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-02-04T18:44:52.103Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged; 
suggested_attachment_session_id: 51db91a3-10a6-80f6-8c2c-7a55877ddf82
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9e3ad58-7740-4b67-b726-08d9e80e6e65
x-ms-traffictypediagnostic: DM6PR12MB4862:EE_
x-microsoft-antispam-prvs: <DM6PR12MB486293221A5CB1D97A480E31F7299@DM6PR12MB4862.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qBdlyy8mlonaisEzVNpLHXT5o9iGpfA3DMfsCeZ3/TEb48XLW4Lcv+9mM90i/kNm6ShcRBjLV4W36K7jxeFwBy9O0Hk2yD6Ae4JJBONiqCda08DaBIeSOY5R+GnviywQ6tsr6R5CGIq+rilHBwFZiyQF0t9NeP9u6cEgDIbrcdH4iJp4mG0rRPr/le7wEqrJ0XqBBoG4Pm74380A6+71XlBfsSHuu0bjHSJAKBHaueu+vQliNgMtc0qavdM38xfmZZ0nZ2JYb4Skz0oMnVlY/bUFGJQfl8WwgaBJ8rQ/6hKa4QsgO/WGtl3dujJ7fJf9Aiqmgvw+s7YdUoh8sZL+XTnuW0Jkj44dmpfhH7bW+ZsTtAbLjfoZGEdV/1B95u/RP4wsjKUk66EWv6Fr/r3vOR36UnDhibvz4MJhnYx1tnAILdABETccjANIvRw7LDQvJf+VTRzCpBsN/fRlw5DNn6xEvNRndUdxwuAnF5XIOp1nZVqUpyQcnaicolJ8Fa1Tn4D/eWnQ7zPFskLV5NLIP0F6UVgP2t8KX7GMkjPOeRju7qllIsSGEEbxiorJtuxRsg3b0nzT7ugTAsSLLpBkGNXxYY8BTPV5qYnUXnmx5asDwrphhEkNrOka1BM2UmJpzx05jgWDpHL93hnsf6QowA6caBvHSe9PF4lQZVAxgyv73UWz7YbxkBweNMZsGTgh/H+XMcs/wWG4zNMLt13M3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(5660300002)(38070700005)(2906002)(26005)(53546011)(38100700002)(110136005)(186003)(83380400001)(54906003)(508600001)(55016003)(71200400001)(66446008)(66946007)(66556008)(76116006)(122000001)(316002)(8936002)(86362001)(33656002)(9686003)(2940100002)(52536014)(6506007)(7696005)(64756008)(19627405001)(66476007)(8676002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?40sQEmp380jJXybbSok0mQtUGavdEe6czL+47A/gmAPLw/BMPgiMtL8uViAL?=
 =?us-ascii?Q?Df7jnjgelVe4+Kn1wiKkBu2lIpmHPoaR25Rp2u/qlVhJL4CcPkgsETBBYMsk?=
 =?us-ascii?Q?uqJg6jjPj1R83IJZ0Zsx2332iwWZ2qEq/kVUaAuyvp2A+9aE5B19cE+jSYUg?=
 =?us-ascii?Q?hPJYy7bLKx7HEPd3EXYgvqaptuuLo6Bw/MQPfdpktvKUHr+M6yD31zLvd+iY?=
 =?us-ascii?Q?t/51LsRkYgaa0GJ90ReqeQxqnNzUqLjjvCB96nCUC8zDS/SZC44Q/6wjtvAg?=
 =?us-ascii?Q?DBRlf7WUTFRP5HYkEAgJpEpA8OP/Syi+P5Gj/UJ3gI88Cac49BekR83awYOm?=
 =?us-ascii?Q?xU0gM233YqpavxJGWYQ4MECNuTgd0zB2iiEQGKIJ+GE2w0mKD+ou5Wpf2KAq?=
 =?us-ascii?Q?UccErAW65ToSrukU/vRWnRDXmLSjCDAtmmDi35XtoY54GuJNCyt5aBBB+UDd?=
 =?us-ascii?Q?B6GEHhyl7aBQ0aBmXJ2ViE444R7DkB0PXBNrwqSA8GFk1/DECZkyJAoizf3i?=
 =?us-ascii?Q?LSUIeDlMlzIGnCBHjR9ATY5n75NMauaXgpFT8HAexE9IGnTyUwvRKtVISqDJ?=
 =?us-ascii?Q?1Ua9E5cNxQhX6mez1H5UlmXTRKnrWjA547QXWiiew6YEvWb6rYWVj/G66GLn?=
 =?us-ascii?Q?x/1HnXD8vnCOARjiwFGBgp/N5oGASfKFdApIQhiLj9NT8mKRVzWavRkAqnEg?=
 =?us-ascii?Q?XNdqj8FJygMfifbaGke83ODothsMiXzC5HsXCNSjyM2VQDSvH0Ckb5gwgfyp?=
 =?us-ascii?Q?CYVFp8hF5eI7GalRuyJbzPWG17CAtW5XD8eadBNcXzCZ1ZdNbPeaWs9Yj6+Q?=
 =?us-ascii?Q?l9keBITo8Pi08seRkug33VhyNdOfA5oZeerIEdavDeEm1whcYATg73vzj09B?=
 =?us-ascii?Q?ztqX8tAvFkBagSKacmluPKMiOjqT1AffOwD7A9P5deT3u8otqQCeDhuYanme?=
 =?us-ascii?Q?7cDb9xOmTquMvq9ct1M3OA5FkQYdVc43Nu327dn3eg07tosHa18N69Te790h?=
 =?us-ascii?Q?AysFPVYLx0JDQPuIo6AcUWY1BrNZi8AnAWy+BcM1yi0sm9HW6AgzP6aH9rps?=
 =?us-ascii?Q?+2krp8Pf2fgysS8SKAPvs4atAmf2DoSAx/CRpZiwAxREb5lS2CrUQlHRs1JA?=
 =?us-ascii?Q?AxDD4fXOiyWVTSvdJL9WWVktHS1QRyVtvWKeO+sVickdrn3A0VpW74hUMWL3?=
 =?us-ascii?Q?LPa5KXVLUYETEVsoKRsvZkNdbt62p/156SZE9YcHlygqwMVlBkTVqDV6+Pjm?=
 =?us-ascii?Q?eGWa2KgpusiKVvREu3eXjMRUXKwXasQjGv8I4iWi6RfAmo/c2zn43dx/HjJS?=
 =?us-ascii?Q?zirE5ZymPJVKnr7NJL9Cm4X8NLzuYAYTe+Cf5RHvLRjIHIYpIOOJvn1nVvgv?=
 =?us-ascii?Q?n/WHqk5xtTI62Wv+FslWKKObBY/A/ZjPXUzpgNdimikfOR9+mxatc9euzT9v?=
 =?us-ascii?Q?PVm7ofLk7LgCpXXM3Ldhe+1+Uoms0k3b2wpWBo7bNIbs8Jxwjdh8l2YbtsLa?=
 =?us-ascii?Q?N6beA6Pev4tLDMwPT75QGhzdA9khzsQLHmIEuu474tai7lWtt2y7MWp2OYsO?=
 =?us-ascii?Q?GGfx9cVOIrQDqNxC25Yzy3C9ZCImGbff+7BKmpLCRviggYu6g/Xxcb3IAC/V?=
 =?us-ascii?Q?+ZCys8kWjAAxmj3RfEicPtY=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514487E169A1614431BCD1F7F7299BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9e3ad58-7740-4b67-b726-08d9e80e6e65
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 18:44:52.7114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /aIGOFy8DVwrFz3V0A5z+twgaKmDXKXIx9h/bO9u82/ih/yTxQNnMYTxvfAE4QUF5cK0GfmQPVAiAodXwANNiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4862
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
Cc: "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB514487E169A1614431BCD1F7F7299BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Seems like this functionality should be moved up into the callers.  Maybe a=
dd new IP callbacks (dump_reset_registers()) so that each IP can specify wh=
at registers are relevant for a reset debugging and then we can walk the IP=
 list and call the callback before we call the asic_reset callbacks.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Sent: Friday, February 4, 2022 1:41 PM
To: Sharma, Shashank <Shashank.Sharma@amd.com>; Lazar, Lijo <Lijo.Lazar@amd=
.com>; amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Somalapuram, Amaranath <Amaranath.Somalapuram@amd.com>; Koenig, Christi=
an <Christian.Koenig@amd.com>
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler


[Public]


[Public]

In the suspend and hibernate cases, we don't care.  In most cases the power=
 rail will be cut once the system enters suspend so it doesn't really matte=
r.  That's why we call the asic reset callback directly rather than going t=
hrough the whole recovery process.  The device is already quiescent at this=
 point we just want to make sure the device is in a known state when we com=
e out of suspend (in case suspend overall fails).

Alex


________________________________
From: Sharma, Shashank <Shashank.Sharma@amd.com>
Sent: Friday, February 4, 2022 12:22 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranath =
<Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.co=
m>
Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler



On 2/4/2022 6:20 PM, Lazar, Lijo wrote:
> [AMD Official Use Only]
>
> One more thing
>        In suspend-reset case, won't this cause to schedule a work item on=
 suspend? I don't know if that is a good idea, ideally we would like to cle=
an up all work items before going to suspend.
>
> Thanks,
> Lijo

Again, this opens scope for discussion. What if there is a GPU error
during suspend-reset, which is very probable case.

- Shashank

>
> -----Original Message-----
> From: Sharma, Shashank <Shashank.Sharma@amd.com>
> Sent: Friday, February 4, 2022 10:47 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Somalapuram, Amaranat=
h <Amaranath.Somalapuram@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>
> Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler
>
>
>
> On 2/4/2022 6:11 PM, Lazar, Lijo wrote:
>> BTW, since this is already providing a set of values it would be useful =
to provide one more field as the reset reason - RAS error recovery, GPU hun=
g recovery or something else.
>
> Adding this additional parameter instead of blocking something in kernel,=
 seems like a better idea. The app can filter out and read what it is inter=
ested into.
>
> - Shashank

--_000_BL1PR12MB514487E169A1614431BCD1F7F7299BL1PR12MB5144namp_
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
Seems like this functionality should be moved up into the callers.&nbsp; Ma=
ybe add new IP callbacks (dump_reset_registers()) so that each IP can speci=
fy what registers are relevant for a reset debugging and then we can walk t=
he IP list and call the callback before
 we call the asic_reset callbacks.</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Deucher, Alexander &lt;Alexan=
der.Deucher@amd.com&gt;<br>
<b>Sent:</b> Friday, February 4, 2022 1:41 PM<br>
<b>To:</b> Sharma, Shashank &lt;Shashank.Sharma@amd.com&gt;; Lazar, Lijo &l=
t;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.f=
reedesktop.org&gt;<br>
<b>Cc:</b> Somalapuram, Amaranath &lt;Amaranath.Somalapuram@amd.com&gt;; Ko=
enig, Christian &lt;Christian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler</=
font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#008000=
; margin:15pt">
[Public]<br>
</p>
<br>
<div>
<p align=3D"Left" style=3D"font-family:Arial; font-size:10pt; color:#008000=
; margin:15pt">
[Public]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
In the suspend and hibernate cases, we don't care.&nbsp; In most cases the =
power rail will be cut once the system enters suspend so it doesn't really =
matter.&nbsp; That's why we call the asic reset callback directly rather th=
an going through the whole recovery process.&nbsp;
 The device is already quiescent at this point we just want to make sure th=
e device is in a known state when we come out of suspend (in case suspend o=
verall fails).</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Sharma, Shashank &l=
t;Shashank.Sharma@amd.com&gt;<br>
<b>Sent:</b> Friday, February 4, 2022 12:22 PM<br>
<b>To:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedeskto=
p.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Somalapura=
m, Amaranath &lt;Amaranath.Somalapuram@amd.com&gt;; Koenig, Christian &lt;C=
hristian.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText"><br>
<br>
On 2/4/2022 6:20 PM, Lazar, Lijo wrote:<br>
&gt; [AMD Official Use Only]<br>
&gt; <br>
&gt; One more thing<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; In suspend-reset case, won't=
 this cause to schedule a work item on suspend? I don't know if that is a g=
ood idea, ideally we would like to clean up all work items before going to =
suspend.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Lijo<br>
<br>
Again, this opens scope for discussion. What if there is a GPU error <br>
during suspend-reset, which is very probable case.<br>
<br>
- Shashank<br>
<br>
&gt; <br>
&gt; -----Original Message-----<br>
&gt; From: Sharma, Shashank &lt;Shashank.Sharma@amd.com&gt;<br>
&gt; Sent: Friday, February 4, 2022 10:47 PM<br>
&gt; To: Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt;; amd-gfx@lists.freedesktop.=
org<br>
&gt; Cc: Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Somalapuram,=
 Amaranath &lt;Amaranath.Somalapuram@amd.com&gt;; Koenig, Christian &lt;Chr=
istian.Koenig@amd.com&gt;<br>
&gt; Subject: Re: [PATCH 4/4] drm/amdgpu/nv: add navi GPU reset handler<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; On 2/4/2022 6:11 PM, Lazar, Lijo wrote:<br>
&gt;&gt; BTW, since this is already providing a set of values it would be u=
seful to provide one more field as the reset reason - RAS error recovery, G=
PU hung recovery or something else.<br>
&gt; <br>
&gt; Adding this additional parameter instead of blocking something in kern=
el, seems like a better idea. The app can filter out and read what it is in=
terested into.<br>
&gt; <br>
&gt; - Shashank<br>
</div>
</span></font></div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_BL1PR12MB514487E169A1614431BCD1F7F7299BL1PR12MB5144namp_--

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651A7ECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Sep 2022 04:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA36810E19E;
	Wed,  7 Sep 2022 04:33:31 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2089.outbound.protection.outlook.com [40.107.100.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE7810E19E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Sep 2022 04:33:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFol7MoEV5bdUJ4h/xJM66IF2pW90bxZN2i1Jfs0pfKxWR2buHGM5PPILPSfe3MITNUWBjMrU5cOthvpb6PpxSAfnh6Q1PL3FsNVnTqoXppGcWvjYc9SwWP1hfM9d7ROZiYjL6BV32vQ3AkG4tkdSo59EjDAiCEaUfTl2Y0bfWXcCELYhAUTE5O2of/0iE06Sw/667BMhtRPWMaqv/15v94XAzGmbB4wg/wzjwBB5OF24XEORybHPgNpA+NfElIQVDTXXADM35/F74oFHC93GrnsABH8+CpT8FvOCyoh5JXBOz1Cdx9YWv/V3rOlDxyIWfLHEzAsXYF1Kd+F+7AMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGoSWSuSHUUgwr7eYKDBl8r3+OMSytx35pPU4/+J56M=;
 b=B8G+GzIbHrJhLFiL9QlCcBEvgxCTYBjjTQFHwIPhxKGAEYkqlpTOLS03VJtVKGy37rRUKXGpCSI2pk/jTH04EgorMhTKR9e/siUyoXu2xmbwmouPFI78Il3YtNmw4qWPHkfJNieCpbtjeDC1RGDIfjMQ+oawbwwUt2G2Ysq9QtUfpfXvwbYoyrdbzuA7W83pvtldCCpWblFz1cwmPpCsV4ai+qan/p2BfbV8VRLoyEhmjMixDBCQFCVkfDahmfnnzzgh1sNoHg+MfpFlf6oltDe7x3XkRiftr8ygR4Ar8k84mwWWWNEHNIw3YNSZmHivt6m74ybG+R/1/13u/1kZlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGoSWSuSHUUgwr7eYKDBl8r3+OMSytx35pPU4/+J56M=;
 b=CW8CJVUf8iRh9VH3CVXsEyuxTnNhdeECGici+t6ftfBquOPXwkIqqzycqxQoscrY17tD7ruD9pJjMVLqSEq/tjkWi76hgpAL1Z07uSKQ3pdau8aWWntoNvdJI263TbK7t07/cz68wFzn4/MnObrLGzuu5fYKnZgFTCTcY2+rXT4=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.12; Wed, 7 Sep 2022 04:33:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6cff:7529:4f8e:b8d8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::6cff:7529:4f8e:b8d8%4]) with mapi id 15.20.5588.014; Wed, 7 Sep 2022
 04:33:24 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>, Yury Zhuravlev
 <stalkerg@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
Thread-Topic: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly
Thread-Index: AQHYvvFxHK9cuZH3tkKsW4vKsnXj4a3ShheAgADg/OA=
Date: Wed, 7 Sep 2022 04:33:23 +0000
Message-ID: <DM6PR12MB261910F2C8C4582551440C61E4419@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <CANiD2e857Jm-gFzr4jRxvw3AuDHJPfATRzmtZ3PipDwQOpYwvQ@mail.gmail.com>
 <BL1PR12MB514410A67CE80EC9C55C74C7F77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB514410A67CE80EC9C55C74C7F77E9@BL1PR12MB5144.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-07T04:33:20Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=18573edd-f8f8-424d-acc5-9f11180e7c67;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec354dda-9742-440b-9cff-08da908a19da
x-ms-traffictypediagnostic: CY8PR12MB7290:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0sduFMdJTywBco8d5QQwBkmLmt27THj/9t2lKAUS/Au6gjruZvpn1qI4/Key5FuuyD5Gom0kQjqDJW1sRWyFz/6MjgPT/XgawcbxMmpQKVmHffq9SQdF2BgyW/pb3YPQCvnYEPikQHvFKui/OIDuF6+IssT6duHwf5bfewVPu1wZTHSXy5ao13UwFfj88eM+ggJEtphWIdPqfrmY2Hc8ZwueIEeeyVCx5abylR+qQaegsHbjdNvpJ1IgAbc3blSSsSrMdTgUvwYECoV+KU4VKpncwJmwohlth2i4CDv8vCsYGCDakeyEChvHbMLzRPFB7mQ7K8uMvD4oDiTCc62c88XzThEWQebDwbwZ+9KPjGcxOO6EuUfPepeeVABLCiq1s2Dl8iCnas8BKkKTQJKY5BFfdI2e1Y9kiLM6ZWiXLw1ID2YAOqrkT2K6m7e7sgSyhLsrigfVh9jZcPza3+xfESoLDmmzihn3vpE7DPHh/ROuIXz2weU+lGwrg054gWvJHrl5v8q6g2bvNRIuHz2b/v2UTEUa8mS0xVRp6eZhJXPXY7eQRqZUSFBkniI5yhRz28bMtQontZ5Zw0KSdWqKfcbNixAEnypxIZYWUBBCeBgr71ngNCt+a3ZXpneQLDBLZtF9OQ4OsJPb0NwUPqMwQXzu6Y17Fc2dva3x0ZlL+4zsn4MoKTCArcaQ5oJ15jG8yF59Htnn1jQFa0pg0SUDYVPJzgNjo4uVIsYP7rXiQF79fCLW7AK97JYWYz2Ngst6LOtCc6NFaXVWhLGM5vG4qmr+mKllp/FSZf6uXa3Ei24=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(366004)(316002)(6636002)(166002)(71200400001)(55016003)(38100700002)(41300700001)(122000001)(110136005)(33656002)(66556008)(66946007)(38070700005)(478600001)(7696005)(6506007)(83380400001)(8676002)(64756008)(966005)(76116006)(66476007)(66446008)(52536014)(86362001)(186003)(5660300002)(8936002)(26005)(2906002)(53546011)(9686003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iYYdOpuJBzj2TFWBpv4EJXTvTaM7iYcffRFiWlI+jHxOgzmPO6WBTreU79ET?=
 =?us-ascii?Q?BqYDWrJRUpl2Wby/zdbavxKYyLF/shLOGLp8WZ0OsPa/gOl6DjFoB88zf1uH?=
 =?us-ascii?Q?Dl4yNas7dkLVW8//ZUY1h+UZ5SEFULIh6tVJfR6VGuxqifl1vUN69UHpto9a?=
 =?us-ascii?Q?aAy6vel15WDq9+MiSqHGjjDO+iWVgEEIikEZqhxyQjS/C248rjX2N9PBtIyN?=
 =?us-ascii?Q?wa7ZCTRv0vkua46h4x8qNdNGij6B86S7KgM2rWRozNDpr7lUoNGkoV6IBCt4?=
 =?us-ascii?Q?q+cFCRXxXGGWT1qoNVYpGKYqimmpG/H5+K8twOor13+aWvI0a51nQQmAz+1p?=
 =?us-ascii?Q?DEp8CedwoXOfa1QZ8vJiEIySjm32cPGnzV0pmtS3nK88tAbu+RrfC1n+Lhc9?=
 =?us-ascii?Q?95TsIZw+yaA3LAgXbTqMxXxEqOdcWcL/NJOkEE/oWgvRZ+umRo8ENOI2qKNr?=
 =?us-ascii?Q?ZG61oBRovugwXTNZpUfNje1YlPJ45/tiV/T4wghzW6Fz+xQk8eXWOLN1HvdH?=
 =?us-ascii?Q?IxIhT7pA8n7grzCbfEHCLtj5tlwkzk5UriA/UpTxFfWHk1blHHHGvWKR2JP1?=
 =?us-ascii?Q?8YYAgJnrrwkx+BIy6O6sCzBQI8PHwZuOG+YzPjggHffEQ1qVZ1MYju2SkvWt?=
 =?us-ascii?Q?oJVcrlNIvFcJONVBFT5YLK0F23fPbcjDGrUv5CQn1N+xPbxgNAtKlrYJ/6b+?=
 =?us-ascii?Q?t3q1buwdKrB7vu+OPM9wrJKy6cjud04ABeMz43vDQHsQd0TKRSoPq1MNwuZ9?=
 =?us-ascii?Q?LnalzcWID9dSgLDzEroAkFhAPIH+cP5uawHCZbnrSTDdoSQ4Dj880JwD2TRv?=
 =?us-ascii?Q?yPkWBoilBKNqpQuxNvNMekw0SRzCQ7Dy8u5ety2g8NEH9NnXEndA99eIO4JZ?=
 =?us-ascii?Q?LPqEh/C2SCf7c+1ICEr+hsCJIQyiqbDkFF7pM9H+dQzsXa8JJwAYrx03RJWo?=
 =?us-ascii?Q?a17AJdcrJLE1T4tUGtoFwCpbXKpsyaaJfQC9ZXggI4tQxxL86FfpeeOlS08N?=
 =?us-ascii?Q?t6KgjzZGwkCRTvG8u29i56/c6iv20bUBpONlMmEjoF6gteLpSl6iSULJPZhQ?=
 =?us-ascii?Q?LPZ3Gl/qLXunqOHrbRBHTjcGtOir+jx2RzBUUVqUCD3PJNhor2gbdPJeQI3T?=
 =?us-ascii?Q?mXgijiglhme0vBA1Epvdu2X9RlHG4ww4juPY8762z4jHQHyP3qRr4rJwCDlO?=
 =?us-ascii?Q?jyAZapB3RIL6Nl+tQ55FcslbUaBk4QlYAADVN1QomHElBiLZbbTrA3AAtDi/?=
 =?us-ascii?Q?b7cH115ipJAdYxHDdQYZTK8ddgoOODlH3PNEbzzJmQGgrDVevH5O45oVE+Rr?=
 =?us-ascii?Q?Yk1ojmW71KBf4FsZ03um6BMhi2HiUv+Ynxmz2GGddr/6PkjwkZYIRWDM/ALt?=
 =?us-ascii?Q?As+fEQZgmjDAle0d0URR/kRJNmISQHtwnH6gA3IbbYc4UjxX7w5yJGSBBLAs?=
 =?us-ascii?Q?Z8ZYAc1LLAzNmkgDLiHM0JffNRPImE9svn+DtyMSgKkVHnJuWwJ80kgRpLXm?=
 =?us-ascii?Q?oSnfxLbvo6atLIq6sZWirknxLhKg6Kn+HDT7KGHSQcV8nxHFbvxLWX5+jv4l?=
 =?us-ascii?Q?cFjYEDoYHTjjo/68Y4U=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB261910F2C8C4582551440C61E4419DM6PR12MB2619namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec354dda-9742-440b-9cff-08da908a19da
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 04:33:23.9678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n8ypDvxn7ZmqDN/BqhYM8o/BAehktm2gp29scu861hl+/NH6GlQC3vKvmP6BMwYH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290
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

--_000_DM6PR12MB261910F2C8C4582551440C61E4419DM6PR12MB2619namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Thanks Alex and Yury.
The changes seem reasonable to me. Feel free to add my RB: Reviewed-by: Eva=
n Quan <evan.quan@amd.com>

BR
Evan
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Tuesday, September 6, 2022 11:05 PM
To: Yury Zhuravlev <stalkerg@gmail.com>; amd-gfx@lists.freedesktop.org; Qua=
n, Evan <Evan.Quan@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly


[Public]

@Quan, Evan<mailto:Evan.Quan@amd.com>, @Feng, Kenneth<mailto:Kenneth.Feng@a=
md.com> can you take a look?

Thanks,

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Yury Zhuravlev <stalkerg@gmail.com<ma=
ilto:stalkerg@gmail.com>>
Sent: Friday, September 2, 2022 1:24 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 properly

Hello,

During the setup, the fan manager https://github.com/markusressel/fan2go<ht=
tps://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.co=
m%2Fmarkusressel%2Ffan2go&data=3D05%7C01%7Calexander.deucher%40amd.com%7C09=
03d6788f924045996108da8d086ecb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7=
C637977365572428876%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2l=
uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DIOJR10xHaW9cUZ%=
2Fv0Q%2BZDFFQJ1pbv2dUKP0zpxK4s8M%3D&reserved=3D0> I found that my Vega56 wa=
s not working correctly. This fan manager expects what read PWM value shoul=
d be the same as you wrote before, but it's not the case. PWM value was vol=
atile, and what is more critical, if I wrote 200, after reading I saw ~70-1=
00, which is very confusing.
After that, I started reading the amdgpu driver, and how fan speed works, a=
nd I found what PWM value was calculated from RPM speed and not correct for=
 my case (different BIOS or fan configuration?).
Because it looked wrong, I started looking into different implementations a=
nd found that Vega20 used mmCG_FDO_CTRL1 and mmCG_THERMAL_STATUS registers =
to calculate the PWM value.
I also checked how we set PWM for Vega10 and found the same registers. Afte=
r that, I copy-pasted the function from Vega20 to Vega10, and it started wo=
rking much better. It still has some fluctuation, but as I understand, this=
 behavior is expected.

I have no in-depth information about amdgpu, and the original function may =
have been for some reason (maybe for some broken BIOS?), but I suppose some=
body forgot to backport this code after prototype implementation.

It would be my first patch here. Sorry if I skipped some procedures, will b=
e appreciated it if you help me.
Also, sorry for the patch in the attachment, I have not been using any mail=
 programs for the last six years, only web clients, and it's strange to do =
it nowadays (PRs much more common...).

Regards,

--_000_DM6PR12MB261910F2C8C4582551440C61E4419DM6PR12MB2619namp_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderc10f11a2, li.msipheaderc10f11a2, div.msipheaderc10f11a2
	{mso-style-name:msipheaderc10f11a2;
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks Alex and Yury.<o:p></o:p></p>
<p class=3D"MsoNormal">The changes seem reasonable to me. Feel free to add =
my RB: Reviewed-by: Evan Quan &lt;evan.quan@amd.com&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BR<o:p></o:p></p>
<p class=3D"MsoNormal">Evan<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Deucher, Alexander &lt;Alexander.Deuche=
r@amd.com&gt; <br>
<b>Sent:</b> Tuesday, September 6, 2022 11:05 PM<br>
<b>To:</b> Yury Zhuravlev &lt;stalkerg@gmail.com&gt;; amd-gfx@lists.freedes=
ktop.org; Quan, Evan &lt;Evan.Quan@amd.com&gt;; Feng, Kenneth &lt;Kenneth.F=
eng@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: getting fan speed pwm for vega10 pr=
operly<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><a id=
=3D"OWAAM804280" href=3D"mailto:Evan.Quan@amd.com"><span style=3D"font-fami=
ly:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Quan, Evan</span><=
/a>,
<a id=3D"OWAAM423795" href=3D"mailto:Kenneth.Feng@amd.com"><span style=3D"f=
ont-family:&quot;Calibri&quot;,sans-serif;text-decoration:none">@Feng, Kenn=
eth</span></a> can you take a look?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Thanks,=
<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex<o:=
p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Yury Zhuravlev &lt;<a href=3D"mailto:stalkerg@gmail.com">stalkerg@gmail.c=
om</a>&gt;<br>
<b>Sent:</b> Friday, September 2, 2022 1:24 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: getting fan speed pwm for vega10 proper=
ly</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<div>
<p class=3D"MsoNormal">Hello,<br>
<br>
During the setup, the fan manager <a href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttps%3A%2F%2Fgithub.com%2Fmarkusressel%2Ffan2go&am=
p;data=3D05%7C01%7Calexander.deucher%40amd.com%7C0903d6788f924045996108da8d=
086ecb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637977365572428876%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DIOJR10xHaW9cUZ%2Fv0Q%2BZDFFQJ1pbv2d=
UKP0zpxK4s8M%3D&amp;reserved=3D0" target=3D"_blank">
https://github.com/markusressel/fan2go</a> I found that my Vega56 was not w=
orking correctly. This fan manager expects what read PWM value should be th=
e same as you wrote before, but it's not the case. PWM value was volatile, =
and what is more critical, if I
 wrote 200, after reading I saw ~70-100, which is very confusing. <br>
After that, I started reading the amdgpu driver, and how fan speed works, a=
nd I found what PWM value was calculated from RPM speed and not correct for=
 my case (different BIOS or fan configuration?).<br>
Because it looked wrong, I started looking into different implementations a=
nd found that Vega20 used mmCG_FDO_CTRL1 and mmCG_THERMAL_STATUS registers =
to calculate the PWM value.<br>
I also checked how we set PWM for Vega10 and found the same registers. Afte=
r that, I copy-pasted the function from Vega20 to Vega10, and it started wo=
rking much better. It still has some fluctuation, but as I understand, this=
 behavior is expected.
<br>
<br>
I have no in-depth information about amdgpu, and the original function may =
have been for some reason (maybe for some broken BIOS?), but I suppose some=
body forgot to backport this code after prototype implementation.
<br>
<br>
It would be my first patch here. Sorry if I skipped some procedures, will b=
e appreciated it if you help me.
<o:p></o:p></p>
</div>
<p class=3D"MsoNormal">Also, sorry for the patch in the attachment, I have =
not been using any mail programs for the last six years, only web clients, =
and it's strange to do it nowadays (PRs much more common...).
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal"><br>
Regards,<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM6PR12MB261910F2C8C4582551440C61E4419DM6PR12MB2619namp_--

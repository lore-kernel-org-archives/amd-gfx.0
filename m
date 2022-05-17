Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EFBC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 17:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419AC113265;
	Tue, 17 May 2022 17:00:16 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D776113262
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 17:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1vOHCnrF2cYuDw0BQHWZujbcCilKoKI20UHdrDr3O2cjEY76Z6rZCmeSQOLh6e35PHLjUl7h/g6A89ZTmH4twInRjJKK/ae93wi0ZNk6YHLhC7B2N9hQ6z+F5gm7G9DrmsockKbTqP8HfyXpNEUd2oBoHOKzP7WyKAk7+iOZ2SgmAi6iY2VpAUyE5s5YZzPE75yed2Ol+Tbi7Lwg1WbUnIR8LrqQFredhCvzKlnuemq3YD/dQypfrgg3QrSKNpvVqEqr/VNIe/EgZERmF2rNFuP2Yp/e6kgdGN9shJxsch9bgBVABnooyfRo2ecJnJYjDbW1YU4PwYR9KVn8yIjQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kpeXpb8ZQHl2wKdhO6R993mYaHJJnGikfjWeCYM6Ds=;
 b=QemLLlPsulRXOZiYewmQi8l8o0R8/i9vmMpDcfczaCnrr2mMMk82yoxAsxtmL7kOYggNjrv/z3b9Yve7SU/iYP7h1LXURmZksqNvyth/0aTM5tSDF/tJZcqDtTKj1AqhgadW4QZREbO/EpNLya2olc0fTU3mjMtxLoUu0uBkqHVwJbX8LJh43mjzRzutbHFEY/MwQfOP/aRpiwexVnygn4GWp5Sl1hkxrARkMn1B7tY/ug95g6lp0eQE7Wl5xA079IILcOFR6QGka7uTIDENBtW54RMVxH8EAneOKSjJtIQYIzJK4sFhn7f/EDiPjv/AvPpgoC3GwHez6c51PXpCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kpeXpb8ZQHl2wKdhO6R993mYaHJJnGikfjWeCYM6Ds=;
 b=k/9GHRZ4d0Us6y8eyOBlallxrRBtZawFh1C1MaAAE+1rz0/mV7NUYAF5umj6R8c5CIFN0MMBzYd4MnZ1hiMIa1jfklgtRrcQZQRm3Uvm7Qdh4l8CzySLEoL+LKzAcrF7Ayq1HUbiGBfqa7awBmncOkm7zaskLd0LO0T1idJjljE=
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SA0PR12MB4477.namprd12.prod.outlook.com (2603:10b6:806:92::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 17 May
 2022 17:00:09 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d42b:7413:ba19:e8db]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::d42b:7413:ba19:e8db%6]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 17:00:09 +0000
From: "Limonciello, Mario" <Mario.Limonciello@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Topic: [PATCH] drm/amd: Don't reset dGPUs if the system is going to
 s2idle
Thread-Index: AQHYafOSaEN0/701nU+0Pi+gyRxwTq0jQW2AgAAAMSCAAAcJgIAAAnIA
Date: Tue, 17 May 2022 17:00:09 +0000
Message-ID: <MN0PR12MB61018A4ADCCF1CFFC37F2986E2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
References: <20220517133944.25612-1-mario.limonciello@amd.com>
 <BYAPR12MB461409FFEB1FE826259EAC9097CE9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <MN0PR12MB6101B804A6C68D3ED85262C7E2CE9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <BYAPR12MB4614D0C7DAAB796E9FFCC06697CE9@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614D0C7DAAB796E9FFCC06697CE9@BYAPR12MB4614.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-17T17:00:07Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-17T17:00:07Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 811ee713-678d-4304-8441-442b5ab494f6
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fbdbe628-f648-4ddb-c800-08da3826b32f
x-ms-traffictypediagnostic: SA0PR12MB4477:EE_
x-microsoft-antispam-prvs: <SA0PR12MB44775B84565C45223C81BB7AE2CE9@SA0PR12MB4477.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2mmVqP+PHMktUZx86NEv+7rBqzMGxo0MrcKW972UdejAaKPAKlZVUXlcDg7feS1LRgiSD9uVc0adrUN16DoE1dW9Q8eXZFon+b1EmI6DDjHnr2tl0Zod3AgaeXnJA3hzddY3gn9K5R+QtlTW7nI97oEjpEydJ7sAcJh/vubQTG+QeAUOFwzK2jRfG92w+Gg63ZPg/zmBRTUoYzh2Py3K5RhhMquOsyaP8hSHWL8duWkwUzvfR2U1aTjmThUCvKw5SfzFpMHcKh/Zy1L7AcYGFRWgNv6Oot+OWwxpWiE88O/2ZITflPRiesL9/sXM7PgwwhA9jksoq6/7qPMOpouXfaU590MUW+AxYJ4RYtcNqqYfByi5P5enWeEzEbgiuzy5DtT/fzsp9VDdM42IZkOch/M0eWSS6xI1nyrFksm7eT3wRQfehg3nIdgS/A+nFk0suBEwPRKbhldDrmNIEhR+NQ91ROf/5ih3aqkbVwGdDgjULHgESONnJ914iC24B6tAwUyuuKQ5ubnMOwFcoWyIn24OpBDRGJq0UZn8sB35BBfHvOn2CFA37Fa7dpOAdWg8EM2W8a4aWQ2qPUnW48Ix2zE66iH5Lzcs9lLuJsXjy8dOIrjPnEBX+xt7sJ8Q9mEtaatIXwwDjlH4NhrNA8/BHnhWkW+WCXss33qAro0rSS7nJi6nl1MuzsAJbkX5mopf4wAB54qBdgzFGtQbH4Kg2A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(6506007)(5660300002)(122000001)(33656002)(2906002)(316002)(38100700002)(9686003)(7696005)(86362001)(110136005)(66446008)(66946007)(66556008)(64756008)(186003)(53546011)(66476007)(38070700005)(83380400001)(71200400001)(55016003)(76116006)(52536014)(8936002)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kztFekBHTJRse98fdl13e+baRHg1IMHpBNrAmYUXYGW9Yusku4aOcLr2+4Gt?=
 =?us-ascii?Q?MrhaLmnjyeuGEXZyqO5PHR9w+TagD9kvTNWJnFCcrWOGEcciRDF/F0WfEq8J?=
 =?us-ascii?Q?I3YS6i9zA1YnfQb2lNSo5bLB8TwQcM4+xNzoKH8xD7eMu+63U9S54rg3CiVY?=
 =?us-ascii?Q?BX43sh5khYfOMTJ+AUR9+OAw6xj444xYPhRp2gpVOFu43c0TLxoqZXpT6kFc?=
 =?us-ascii?Q?na1yd2IsG+JMrww95YYkpTwOUSnB2Nij3oUHrfe8uaEU39TxePjtD4TRBdIR?=
 =?us-ascii?Q?VuVgMTa7FJj3pVu25MDIIFllhPcAP5xrspRdK+HHZ4ytmUKbNrJX8EqcMlc8?=
 =?us-ascii?Q?s6D8PtmNU5Jwsck4QmeWpusIm3t6DojRU8yCfCXfAKbjBHnbWgVDbujY1tpC?=
 =?us-ascii?Q?Ga4Cs8Xia5fq4p2O8xokbGx7nRS3QfLWGoLfz8Jsn1zqDpW9RSPAwoQfp3aS?=
 =?us-ascii?Q?ksLhct6Inm9ZsDXD+BJgs5p3F6f4p5kZo0O2yFcrd2GUz5WksB7QBB6J0bZc?=
 =?us-ascii?Q?4u7agNE/zr26/muackzYLhOeaL/kLRUrDUzo+i9BWh0EV+c0JKRa/ElCaoKl?=
 =?us-ascii?Q?WDEvsDqfq5n5LmrTgQKnaQFq/ZHEYVD5jqj4PNxPO46SeYyE3Tcm1WhqeRcL?=
 =?us-ascii?Q?R3hgw454qbJFX1mrX5EIKXuu2u+/DA535odcb6XBWy2p4lNP5wlKpLrvggGN?=
 =?us-ascii?Q?7p2Z3e4qgjm6T6uWLcDgXFRFrnG00mug1VHjQTMpUS2IZMMZIvtcvah2DohI?=
 =?us-ascii?Q?EaBljF1mVGbz+C6aH1P9HSyU6f1JTbvLfoXoC5yafXmKoYqqzdXkZBPE2k80?=
 =?us-ascii?Q?QI13yTYsBhWaXfmSs2wF51ytufYPSk06hw1qK2+nC0onfwLXqI7UQuSAhPj0?=
 =?us-ascii?Q?awI+o7IwxpqKijFt7FGc39xn9cmBR83Gck/ucblp0Rz0LpTqVb8kA5JeL3t8?=
 =?us-ascii?Q?vGeOW/f7H3BLOqI0HOkaBpAU9u4uWgV2v2kP8OlKDdjs9T9+OfKz5XjBwmgW?=
 =?us-ascii?Q?pc63JbN1u6suqrj8Vid5UOt36O2EQ7ZFC3eNTlXH+5VIXRfpcdu5FBC8Ct0+?=
 =?us-ascii?Q?AXqmPyQfsCZATnUSRf3C6QXnLwSyiRRRwoDqtoYXF61HpqHQqZgmo1hrdHxf?=
 =?us-ascii?Q?oE5jE7FaytsLsUmrAXY3VqRtXU354ZyXvhadxSgp0rYUpK9vjeXZZd+ZS6Zl?=
 =?us-ascii?Q?QFipjmo9w46+QTEE/eOp07z85BHeqYxtgDndBfGCixhiOxatj9Je78bkXDWu?=
 =?us-ascii?Q?OtCUajyEKpfqps0a6+ZC9+SZ2sFaiq+XN1xs2z9wxFOuYX0I8iWu1aEnXtiI?=
 =?us-ascii?Q?CdAkBUli/+PRLaV02TpmDUNGTXTRmV4nqXNHahDBaIaIchZYbmzGRIWcsWt3?=
 =?us-ascii?Q?Jmz0EYt65biyLLmhHcyqfTH1tx0V9FkL9qCDvezRD6Y3W28rVbxeYmL7G3O3?=
 =?us-ascii?Q?fKBBwkDkAi4VMKN3A5b3XhyapSVX0OSGb7oTbEzj7IK25CJ9wIcVL+EgCynH?=
 =?us-ascii?Q?8U36n0K0VQjz213tXe/v/qnlOnxJA3IKh4enQQ7TpQ+mZVaWCwgqOOKkd3vY?=
 =?us-ascii?Q?k6D545kv9Qn3RKT35aK2C04biLYybc8uZV2QZSYR4Na6wjix4cFzuWX/PhZX?=
 =?us-ascii?Q?DXlk9DMm3bn0d2H7GCHOoXxwMwCHWiOOGL6lNHC0KM3mgXpSwt0kP85lsCSS?=
 =?us-ascii?Q?4BP6FXct8AWtqbhYtW6UA8JF6URYT8Da9t9mO+Y3fjuDwgjeR2vF0VmZ+xlQ?=
 =?us-ascii?Q?8lOmYJOFZzWtgd8FW0Q0wP+BzanpzYO/DUzPNj+mhQk8Iv88lknNrrnfWRBg?=
x-ms-exchange-antispam-messagedata-1: sRhq8Insy1IErA==
Content-Type: multipart/alternative;
 boundary="_000_MN0PR12MB61018A4ADCCF1CFFC37F2986E2CE9MN0PR12MB6101namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbdbe628-f648-4ddb-c800-08da3826b32f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 17:00:09.2356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2QXW1oVdVNvC40l+hflGVC7HJATDkrBhXUSrgeiSzBCIFA7I4c7XadvJ/EJJq6/34atzhJQYn+UkljgacB21w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4477
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

--_000_MN0PR12MB61018A4ADCCF1CFFC37F2986E2CE9MN0PR12MB6101namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

No, it mode2 reset that it uses for failure case.

From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Tuesday, May 17, 2022 11:51
To: Limonciello, Mario <Mario.Limonciello@amd.com>; amd-gfx@lists.freedeskt=
op.org
Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to s=
2idle


[Public]

Ya, second is too lengthy.  Better to leave it as it is.

BTW, is this specific to reset by BACO? BACO entry/exit may take longer (be=
tter chance of suspend entry abort by some wake-up source).

Thanks,
Lijo
________________________________
From: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciell=
o@amd.com>>
Sent: Tuesday, May 17, 2022 10:00:16 PM
To: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>; amd-gfx@li=
sts.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.fr=
eedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Subject: RE: [PATCH] drm/amd: Don't reset dGPUs if the system is going to s=
2idle


[Public]



> PM_SUSPEND_TO_IDLE should be under a compile guard



It is actually.  All of the amdgpu_acpi_* are.  It's not obvious though loo=
king at the patch, you need to apply it to notice it.



> It makes sense to rename to something like amdgpu_need_reset_on_suspend()=
 as it decides on reset only for a suspend situation.



Remember it's in amdgpu_acpi.c.  So it would be amdgpu_acpi_need_reset_on_s=
uspend()?  It's a bit lengthy.



From: Lazar, Lijo <Lijo.Lazar@amd.com<mailto:Lijo.Lazar@amd.com>>
Sent: Tuesday, May 17, 2022 11:25
To: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@=
amd.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.o=
rg>
Cc: Limonciello, Mario <Mario.Limonciello@amd.com<mailto:Mario.Limonciello@=
amd.com>>
Subject: Re: [PATCH] drm/amd: Don't reset dGPUs if the system is going to s=
2idle



[Public]



A couple of things -



PM_SUSPEND_TO_IDLE should be under a compile guard



It makes sense to rename to something like amdgpu_need_reset_on_suspend() a=
s it decides on reset only for a suspend situation.



Thanks,
Lijo

--_000_MN0PR12MB61018A4ADCCF1CFFC37F2986E2CE9MN0PR12MB6101namp_
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
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.xmsonormal, li.xmsonormal, div.xmsonormal
	{mso-style-name:x_msonormal;
	margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.xmsipheaderc10f11a2, li.xmsipheaderc10f11a2, div.xmsipheaderc10f11a2
	{mso-style-name:x_msipheaderc10f11a2;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</s=
pan><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">No, it mode2 reset that it uses for failure case.<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Lazar, Lijo &lt;Lijo.Lazar@amd.com&gt; =
<br>
<b>Sent:</b> Tuesday, May 17, 2022 11:51<br>
<b>To:</b> Limonciello, Mario &lt;Mario.Limonciello@amd.com&gt;; amd-gfx@li=
sts.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amd: Don't reset dGPUs if the system is goi=
ng to s2idle<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Ya, second is too lengthy.&nbsp; Better to leave it as it is.<o:p></o:=
p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">BTW, is this specific to reset by BACO? BACO entry/exit may take longe=
r (better chance of suspend entry abort by some wake-up source).<o:p></o:p>=
</span></p>
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
 style=3D"color:black"> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limo=
nciello@amd.com">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Sent:</b> Tuesday, May 17, 2022 10:00:16 PM<br>
<b>To:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo.Lazar@amd.com">Lijo.Lazar=
@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] drm/amd: Don't reset dGPUs if the system is goi=
ng to s2idle</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"xmsipheaderc10f11a2" style=3D"margin:0in"><span style=3D"font-s=
ize:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:green">[Public]</=
span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:bla=
ck">&gt;</span><span style=3D"color:#212121"> PM_SUSPEND_TO_IDLE should be =
under a compile guard</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">It is actually.&nbsp; All of the amdgpu_acpi_* are.=
&nbsp; It&#8217;s not obvious though looking at the patch, you need to appl=
y it to notice it.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:bla=
ck">&gt;</span><span style=3D"color:#212121"> It makes sense to rename to s=
omething like amdgpu_need_reset_on_suspend() as it decides on reset only fo=
r a suspend situation.</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p class=3D"xmsonormal">Remember it&#8217;s in amdgpu_acpi.c.&nbsp; So it w=
ould be amdgpu_acpi_need_reset_on_suspend()?&nbsp; It&#8217;s a bit lengthy=
.<o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"xmsonormal"><b>From:</b> Lazar, Lijo &lt;<a href=3D"mailto:Lijo=
.Lazar@amd.com">Lijo.Lazar@amd.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, May 17, 2022 11:25<br>
<b>To:</b> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.c=
om">Mario.Limonciello@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<b>Cc:</b> Limonciello, Mario &lt;<a href=3D"mailto:Mario.Limonciello@amd.c=
om">Mario.Limonciello@amd.com</a>&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amd: Don't reset dGPUs if the system is goi=
ng to s2idle<o:p></o:p></p>
</div>
</div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:green">[Public]</span><o:p></o:p></p>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:#21=
2121">A couple of things -</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:#21=
2121">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:#21=
2121">PM_SUSPEND_TO_IDLE should be under a compile guard</span><o:p></o:p><=
/p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:#21=
2121">&nbsp;</span><o:p></o:p></p>
</div>
<div>
<p class=3D"xmsonormal" style=3D"background:white"><span style=3D"color:#21=
2121">It makes sense to rename to something like amdgpu_need_reset_on_suspe=
nd() as it decides on reset only for a suspend situation.</span><o:p></o:p>=
</p>
</div>
<div id=3D"x_ms-outlook-mobile-signature">
<div>
<p class=3D"xmsonormal">&nbsp;<o:p></o:p></p>
</div>
<p class=3D"xmsonormal">Thanks,<br>
Lijo<o:p></o:p></p>
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

--_000_MN0PR12MB61018A4ADCCF1CFFC37F2986E2CE9MN0PR12MB6101namp_--

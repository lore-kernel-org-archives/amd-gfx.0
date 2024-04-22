Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E799C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 16:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255D410FDF1;
	Mon, 22 Apr 2024 16:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EpBuqm1v";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB51D10F77B
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 16:41:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZFFCGKPcKcEFzLjOP6U/DPOnPM63BvMWrmm63SB5z6GjF/OQxF7z9Ac63wr2U8KjeOXLIAnXgRF+OvyjlNwMMBvNCp6bSAjSvpy22vHf5hguz26blR6HuDuQ0CwVb8a4fKqCDeLqvT0wE7fvaLOHPB4bgb6haDwnfebtLdBPKLgaaJAswN+dww3KLn3QgXA74ggnD3LRDyBcFO9N0tXr8wTKk/bkN3BT+7N7T2zcw4nz59u1qC9IyY/YM15gzWVtjW4PiLbT8VetZUJmFBgnVKuCAnW9p6tZR2aDS9bC8iJK3dU07zFD/LijUqYlOpKtVRHkMj1ltEbFHy3Pn1Xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxYZOUKUXEF8M0wQ5+JXhfA/opUtLqMcG1t49otfHRA=;
 b=mztskj8r0QUDIFT5IOolzIlbqsj51FkLy4FUFPeMeHMyKK/889cvjqDUNCmQLv0VxfZXeQkHcXahKXMzRypOyH5b+dS0cMITSRuY+Zws7CqSdOKEwvd64WMjqy5/ulXvznc0/MUE/U8HFq/hP2oryvfUxICwWxquei2nt/yO4ZUsK0UuqHgJTy+BJQDMmVVaY5zSxH3AY9vfInX1mjg53mlYqZSs2gmaM16Ma/jG3q/UCumhpjqYAe14HiQXW7qceVDdMxUPeanK7TskKhzsY0MBRtV79E+RWI3WQPUIrRvhn2CgbolPFW/IXPwX1/WJF3ibq5omtBgJ5iWvqb8Tdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxYZOUKUXEF8M0wQ5+JXhfA/opUtLqMcG1t49otfHRA=;
 b=EpBuqm1vTV/emXWnh4e8A17pF9355KeuCfPhL5If57rytp9vwcV2vLbOwfRWyaNfA5cZa8kAfVT/VEVoOepSSoqqUuqF3/LwWsH5PTy4jMqdIQ7a6t3LE3784LjvW8VhyEicV/XfI2uFgzPd8ouAmZLhIX6uSpCBTra08oTQC+8=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 16:41:38 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 16:41:37 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
Subject: RE: [PATCH 00/37] DC Patches April 22, 2024
Thread-Topic: [PATCH 00/37] DC Patches April 22, 2024
Thread-Index: AQHalMm/C8DhOBJ4dk+4yaX/ZC2HpbF0fjjA
Date: Mon, 22 Apr 2024 16:41:37 +0000
Message-ID: <DS0PR12MB65344F532CF716ABEBF39D929C122@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=e4a2e452-780b-4799-9955-8e7b1b431005;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-04-22T16:41:34Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH7PR12MB6489:EE_
x-ms-office365-filtering-correlation-id: 85127ee3-ce96-4cf1-7d37-08dc62eb1455
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?us-ascii?Q?LNHuWVTY5s3VynllJvqytK2g30QkLb/7RvvW9tuxqUKCzjOUW5Di/+ZJjnJ6?=
 =?us-ascii?Q?v5TkXExq8S1ZQRdrXZoWBt8TH54aY4hHgNVILnDp9D6AiTwSVlg2PjkAznAR?=
 =?us-ascii?Q?AiDoS1ekXbsxP6phwfcZrRLSEMf6iKJqcWH5WSFtHYCs6lIFoa4AbmB4UEdH?=
 =?us-ascii?Q?Zc8S+3g9ADynEeNUdcOR54loydMQCRCXzoF7PS1q/Ee0Ns3JVKLWLs0BzO1z?=
 =?us-ascii?Q?12lguNG5E5jz+zw/1B0Ay7J8FYA/kpzceDye+5ZwMt7ZFvUaRdEMvLQN2uYg?=
 =?us-ascii?Q?wdvwMhS9D5TtN4Yr16WxBSV4v1ydcuvEnRe8DOI5VcZTtC8PjuCLDSNxhrK/?=
 =?us-ascii?Q?5LRYJbUkS0+uyUx+OZUYQj2fIPqM1wyZ0N7vdLTlJstZsBxiWSiXePcLBnzR?=
 =?us-ascii?Q?oZHB8tMIXaRDv+uS8EOsXkWXjIurjIP1RId6bN3L9Q30KuOgS4TBcM88eCyA?=
 =?us-ascii?Q?8V/ZZ6+XXHqHq8EZmVCvcYh8zQXl1oAFRmKqvfmFc9Aibp3vaYfiWR3f3N5P?=
 =?us-ascii?Q?DxVMoBI6ZVVDCrZwx4E/5E0G6KzkzQJdmTFcKiDWGX4W8wxUWBsta1GwCIe0?=
 =?us-ascii?Q?tb6L1kjDgcOEGl1zTvFCr9B2RxxpVD6pPF97v9JuMY9c2Z//YOm0Tz3sMRye?=
 =?us-ascii?Q?r1AZ6hGIIWHhwNZZH/WqaKw3Yat1Jm9kIbIqLfJsoCZ4l9znw8SaymVq786o?=
 =?us-ascii?Q?g/DB7/YewV90V0Y+zs6Ja0SnTc06HEJXgywatjylPxwJ0T60QIi5GFVK4P+c?=
 =?us-ascii?Q?6NLgozGYLraKPERm25YIN7Ii09o8kPaKPp5dIbb6f1PivlfhMZe0JWIwfgAT?=
 =?us-ascii?Q?r2XPpemXdZX5/YLa/PWMc+ch0ctrJSx404f8HmCGmtwF/NSRSBY7NWSg9eK1?=
 =?us-ascii?Q?CMUboFxfR5CUR8AMw/ugomkISHdAIU5ZUEFjzAyWd9Go4I74AegZZs5q++5i?=
 =?us-ascii?Q?MeUcN6dZiSU37mxBhLpJQHPS8Ir0poUwjQkImssHR1dpXFfbg4teHvkIhnjP?=
 =?us-ascii?Q?3sLDnGtJCpBDP2fBSUK2iGtp5+GvudVmKE/7VVkEor4/vXpiaR1m1sxAmHRR?=
 =?us-ascii?Q?TyjQZ7qQnm0LduvKHI5qbXbP8rPormbnULz60EJK7Y+FBZ+gV4/7aoqzrhGt?=
 =?us-ascii?Q?O2Rmvcqk5dRCEcq6KXp1XSs6KPOO2cLatvJUXvcXJU1OFNbZo4VO5qglQF04?=
 =?us-ascii?Q?dvMiCeNQ7XwP8f2r9WxtBNR032m+iclHdFnrO3SYQli/Q9caC214opoMHliv?=
 =?us-ascii?Q?KBM/Ksmp9Re2jBrtvcaEay3vMBFUXrtDNqoWtyhwA/ElYwZyCEG6IdbbuJiU?=
 =?us-ascii?Q?HXUkWin8MLCqn71FjhqCWvNpdj47j/kBdCB3tIiivWXOXA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rUc3GIiTMDmqq1g7yDuR4+m97Yg0ulkPeBLeAAH5vALRiny7uf7x8hbsmbve?=
 =?us-ascii?Q?V0M1nxuVb7ZMSRnVL303QpFEejanJTQEkIxX9W3Cc7RBPiD+g274OOwmOu8k?=
 =?us-ascii?Q?pVxfHKSbTTDc8I1b+Tn26HRpAOZvUOtbZvSxYeIUWsJy6weG5ub6cxaRyvNh?=
 =?us-ascii?Q?EOdhBEno8Y6beE+93MeQZvSmi5lfhxD3qUrX1A2XShvGrOOXxxy8JElhe/An?=
 =?us-ascii?Q?9zQvbth7JAW8OshLp/9QAZB4Pm1iQr03asiixQkQt6sb/1KCJCr0rZqu2BD0?=
 =?us-ascii?Q?Iyfl1R+QtkyVQdFqmBypDdus2WiRwp95LcgLxlCKmHoRIC3fMPCuDVKgSY8d?=
 =?us-ascii?Q?4UjqO22Z0UADVF7zhV9jgwhlBIuOyiKcfep4tuCnfeTaJmAlmN4isCV8y8/R?=
 =?us-ascii?Q?Xu+IHUwwOjWgFE5LeAV6l+5u24ikkV3Oqk3VWxLKzuJrVUsHpHNcp5Fh0Gf1?=
 =?us-ascii?Q?uC6Lh5xdxadidrM95jJ3uPz/fGk9+WOBsuXZM/bMPH8ubcWCHMj1MnPTbl2Y?=
 =?us-ascii?Q?9McXDUCCnBQ43YYN6Z5i4iPtvJI4s1Q+IoL/IyvgA7KEcYUA6EBOD9iQfkJK?=
 =?us-ascii?Q?XB/fyz7bgqu4U93irVvL71/a9aaxsrKG59MgrUWBOPPe+1SKbWrO/aYTTvOS?=
 =?us-ascii?Q?9J3OC93vBIasZbS9VL1CUuhc/lFr3sQ06ZFxdFlm2hM2tq1c3xTIPsiFavW8?=
 =?us-ascii?Q?Wv25kCPXMzS6fSRjZpxWe2tsgOpqpQBA9H+Rlx9ab+BIDQFyzJgjt2IbGE2P?=
 =?us-ascii?Q?YmUVJBV2stKZmA9eN2eu5F0Jd1z6p66mVJpy+nycpV0voBd7wx72OjR7V7ZI?=
 =?us-ascii?Q?igcaPJ63XNlG9hvSl+iQzLIl8ODQ6tF77K8aYK12wSHW2O/WaXRwPB5hjn/Z?=
 =?us-ascii?Q?g2tI4pusd9zQHFNZMkHbjW0Bi6i4ro7va4CsrfCnhfmCIeqCxSxfhsBwzk+U?=
 =?us-ascii?Q?1LKPX4DE88KmkJYHDnmfLWbaWfQjNgpaq36Yv8PQEB4TX0VGyEAASM9HnwVQ?=
 =?us-ascii?Q?Hgy2+u5qYxzCNsvm9Efu7rwJQm9eGKQYNEIhwGnTrw05se0HonGGPQChOhDX?=
 =?us-ascii?Q?CdrMb4YT6IKH74vEKb+huI9b32qbueybXNZg/SUck+6jx9eq6SkI5OqwlfeX?=
 =?us-ascii?Q?Wcfps9W/ZCpZ3SNuEz6SFkyRY7xfhaH4hejaSdiH9T3wghFUa1Y4487X4bjk?=
 =?us-ascii?Q?R1aVMh3CPpZ+5SeBZXxMpoNqi84V/mwtuwz17QpWoKS2Ng9nxq3UdbUuKU1t?=
 =?us-ascii?Q?wfc/9MvaozYYfGfu8POcpirbbqgVgjO8R744bZyjE9TFDWirOaZNXfQO3X2B?=
 =?us-ascii?Q?iklKiIPmL24ezZR4hXNcPdD9AMiw5CY1dFP1od+OUTTaPaiDJnogab415RbU?=
 =?us-ascii?Q?US+eGIFKt48WJDKda+VAKoKxfUTAU1pIFXSz7ULYXtVdt5SO734oa+RNLkPx?=
 =?us-ascii?Q?hHwTGQg2qrrrfxiMuJQ6BeNIVJEz3rxiXbrBvWJcnNMemeCF/x7i0H7gR9AG?=
 =?us-ascii?Q?CwWRARW5aA7Gffsrvh2ipQQFps3QcKfEcYud6gY002iaWQjIillhwbWLRwnc?=
 =?us-ascii?Q?DFMzdZlIT3dFnO3a1zw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85127ee3-ce96-4cf1-7d37-08dc62eb1455
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 16:41:37.7604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H0HWvIJeptYBmxieiEqqAYhpFu6DDdFP5ot14wRfasZIsi2JkYx7BEBQ8WbsV+1ZR+kv3Gau+Ipcu4E0cg+pVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489
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

[Public]

Hi all,

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 886=
2638f2371 drm/amdgpu: enable redirection of irq's for IH V6.1) with new pat=
ches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Aurabind=
o Pillai
Sent: Monday, April 22, 2024 11:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>
Subject: [PATCH 00/37] DC Patches April 22, 2024

    Summary:

    * Changes across DSC, MST, DMCUB, Panel Replay and misc fixes.
    * Fixes to cursor programming sequence
    * Add some missing register defs
    * Formatting/Sytle fixes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.214.0

Aric Cyr (1):
  drm/amd/display: 3.2.282

Cruise (1):
  drm/amd/display: Disable error correction if it's not supported

Dennis Chan (1):
  drm/amd/display: Fix Replay Desync Error Test

Dmytro Laktyushkin (1):
  drm/amd/display: Increase SAT_UPDATE_PENDING timeout

Ethan Bitnun (1):
  drm/amd/display: Block FPO According to Luminance Delta

Gabe Teeger (1):
  drm/amd/display: Atom Integrated System Info v2_2 for DCN35

George Shen (2):
  drm/amd/display: Handle Y carry-over in VCP X.Y calculation
  drm/amd/display: Skip SST ACT polling when sink_count is 0

Harry Wentland (2):
  drm/amd/display: Separate setting and programming of cursor
  drm/amd/display: Set cursor attributes before position

Hersen Wu (1):
  drm/amd/display: Fix incorrect DSC instance for MST

Ilya Bakoulin (1):
  drm/amd/display: Add condition for dp_set_dsc_config call

Joshua Aberback (1):
  Revert "drm/amd/display: Fix incorrect pointer assignment"

Meenakshikumar Somasundaram (1):
  drm/amd/display: Allocate zero bw after bw alloc enable

Michael Strauss (1):
  drm/amd/display: Add delay to improve LTTPR UHBR interop

Natanel Roizenman (1):
  drm/amd/display: Add null check in resource_log_pipe_topology_update

Nicholas Kazlauskas (1):
  drm/amd/display: Force flush after write to IPS driver signals

Rodrigo Siqueira (13):
  drm/amd/display: Add missing debug registers for DCN2/3/3.1
  drm/amd/display: Add missing dwb registers
  drm/amd/display: Add TMDS DC balancer control
  drm/amd/display: Add some missing HDMI registers for DCN3x
  drm/amd/display: Clean up code in DC
  drm/amd/display: Adjust registers sequence in the DIO list
  drm/amd/display: Code style adjustments
  drm/amd/display: Add some HDCP registers DCN35 list
  drm/amd/display: Update comments in DC
  drm/amd/display: Ensure that dmcub support flag is set for DCN20
  drm/amd/display: Add missing IRQ types
  drm/amd/display: Drop unnecessary semicolon
  drm/amd/display: Replace uint8_t with u8 for
    dp_hdmi_dongle_signature_str

Sung Joon Kim (3):
  drm/amd/display: Reuse the modified power sequence
  drm/amd/display: Fix recout calculation for stereo side-by-side
  drm/amd/display: Update dcn351 debug flags and function pointers

Sung-huai Wang (1):
  drm/amd/display: Handle HPD_IRQ for internal link

Swapnil Patel (1):
  drm/amd/display: Add dtbclk access to dcn315

yi-lchen (1):
  drm/amd/display: Keep VBios pixel rate div setting util next mode set

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  48 ++-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |   6 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   1 +
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   8 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  11 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |  10 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 315 ++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  22 ++
 .../gpu/drm/amd/display/dc/dc_stream_priv.h   |  24 ++
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../drm/amd/display/dc/dce/dce_transform.h    |   1 -
 .../amd/display/dc/dcn20/dcn20_link_encoder.h |   5 +-
 .../drm/amd/display/dc/dcn201/dcn201_opp.h    |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dccg.h |   3 +
 .../display/dc/dcn30/dcn30_dio_link_encoder.h |   3 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dwb.h  |  14 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.h |   6 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |   2 +
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |   8 +-
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  12 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  13 +-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |   6 +-
 .../display/dc/dcn32/dcn32_dio_link_encoder.h |  10 +-
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  40 +--
 .../dc/dcn32/dcn32_dio_stream_encoder.h       |   5 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   9 +-
 .../dc/dcn321/dcn321_dio_link_encoder.c       |   8 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |   8 +-
 .../display/dc/dcn35/dcn35_dio_link_encoder.h |  12 +-
 .../dc/dcn35/dcn35_dio_stream_encoder.c       |  36 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   3 +-
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |   2 +-
 .../amd/display/dc/dpp/dcn201/dcn201_dpp.c    |  13 +-
 .../dc/gpio/dcn21/hw_translate_dcn21.c        |   2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  24 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  23 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  23 ++
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   4 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  44 ++-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  10 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   3 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   5 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |   3 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 drivers/gpu/drm/amd/display/dc/irq_types.h    |   8 +
 .../link_hwss_hpo_fixed_vs_pe_retimer_dp.c    |   5 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  22 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |  10 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |  25 +-
 .../display/dc/link/protocols/link_dp_phy.c   |  47 ++-
 .../dc/resource/dcn20/dcn20_resource.c        |  13 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   4 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   2 +-
 .../include/asic_reg/dcn/dcn_3_0_0_offset.h   |   4 +
 .../include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  |   5 +
 .../include/asic_reg/dcn/dcn_3_1_5_offset.h   |   4 +
 .../include/asic_reg/dcn/dcn_3_1_5_sh_mask.h  |  10 +  .../include/asic_re=
g/dpcs/dpcs_3_0_0_offset.h |  24 ++
 .../asic_reg/dpcs/dpcs_3_0_0_sh_mask.h        |   4 +-
 72 files changed, 763 insertions(+), 264 deletions(-)

--
2.44.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4440C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 16 May 2022 13:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A15010FF7D;
	Mon, 16 May 2022 13:23:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED77410FF24
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 May 2022 13:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRFv3NlZtPKp5hjm0ToqW+l2Y7fzVIiRmvoc2ho5pCcGKRcSom/JixCpZvUSYaoLxQ8+M8fIuU4cj6oPeShio+gRGCcreYYFkMCODMD6YrlWwBEL9/LonYDvEybafCGlqKwRJImbs3tnX+UYr2Fql69/kE4gHw63ShLZ7UixYobQDXPGPnL8bB+NuxmMIe4+1uddKx4uTjmJ1T1Mv1jLoAkfpUQpvONoLQWFgdpwtI5INvfdUbQwYfjW8siYuw/5zf282LdisWLrqK5RQVi+I+0f7rc1BX63pbStQ4RA46FPZRHby76jUThcAReP34LSiMSic5ikg9q/KDps0s39MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i37lw8f1SyUbkK6WoJAyx68a61yA4u2YfspKmMvUlLU=;
 b=aCrSXv4hN6vD3pK0m0sFcEXd+dUJgnXQI9uoxfdp+TByKb3JusCor3dBLNXpkrS66qMkK8rGteVzY5JGAe2B04s51r8X2qP9XqBGBl/9t9OVhtKehGUIjf8beeiB6+7pMUDeLjvxv7ReddTz9OGGPaqYIgy+qHK3GowlCZ1pRsQeHPthMhz3V3+BbL68Qp+SuMKGRbM7Wh8O54YQk81ieszc0yw0A4v4tg/T2X5MbRhJtRtX2f0kk7PDFRDVjaN64RGGXl24PkRu7SjKTSxD/nra8HZ159mNig7dHYe3t1XtH1A7cufPf0GdgsqP9RF0ITRhtXtuJArgv8aKyoRqyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i37lw8f1SyUbkK6WoJAyx68a61yA4u2YfspKmMvUlLU=;
 b=kIHEviyIPgvT4Sdula4FF8JGU+9GUc3znm6uWv2Mqw08biDgPj0BB+PvlSJ3naPCRBry3ZMJKLlvxLLU9EvF8FDkIImVxHu9EnaEZmngbe5wUP8JyK1Gn1JfGMZ+D7FgGPGhmGNFBowkSreKcm/Eiyi8Bc6lOS6OVMUb6IPuLjo=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by BL0PR12MB4705.namprd12.prod.outlook.com (2603:10b6:208:88::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 13:23:07 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b959:96f6:3788:a11f]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b959:96f6:3788:a11f%6]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 13:23:07 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing (Lillian)" <Qingqing.Zhuo@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2 00/11] DC Patches May 16, 2022
Thread-Topic: [PATCH v2 00/11] DC Patches May 16, 2022
Thread-Index: AQHYZw7aH5fVr/Qd4EmQfaWS63scQq0hgU8w
Date: Mon, 16 May 2022 13:23:07 +0000
Message-ID: <DM6PR12MB3529DA896040C5B7AA54B22D9CCF9@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
In-Reply-To: <20220513211651.1312846-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-05-16T13:23:03Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=9aee4921-6b15-454a-bef3-7f17073b83d0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-05-16T13:23:05Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 6a6b2ccc-276f-40a4-90d0-9b6883d4c6b9
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47b5a920-3c35-4575-b8da-08da373f370d
x-ms-traffictypediagnostic: BL0PR12MB4705:EE_
x-microsoft-antispam-prvs: <BL0PR12MB47050D359AC79670787ACE839CCF9@BL0PR12MB4705.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBcqiaPRFG8Sa05QP2k5HMxEiU3/feLPkZrtmwKm48m32T2sxRVYBAoi33dC0EZKedrhPo0qdBrsyzey3koxdy5wBxHRfjVug1IRdVNBB5ry5Pi5qWCHiQdW07NdHPFKm07tw7sdTMWrTSbTlinyHSvstJcxvQQpx7SxLHxfMbQ3BufAp6l1ojQUJNpubGuz5Rz2HjnDeeCAm5BvR6jI+Bl35Dzyn0bSWv7IB0yzLVfXJtTHh8vraxEYn8EcRZEKGssXq7XPZsvBLdR7OZskRfF90qUd/RnhxDhjcclCtoD8GpWeYf5TQH+tSjUZXqb0lQIGSIzvJ/WiARvRSMYJ0j/BI9X6ucOg8bKpq7Hea6Qj/Zp/WmyXTPeVkVsQDwRtXSq5UDR69bYnmcgGh47aguS21+TJuVzkXVtCD0h652cONb9IzPevq5sHuc0DlcAfi7LmjtrIFYbPjZSSzfps4+EH1LTrRPsRLCZA9RE9+0XowpgiG67dKjgQk4EiHP1E7E/d+/chpTLawOn/2IIJ31LIPzPEmPvRpA9o1+cqYdazDJG8Aws6tfnffgrlaVaiP1iudXckmk7jPRmiLnZH8F/wzcEHhVw6d2DpCLYQsZj2qJwmM5XZRVIMKPRgBWCQWyi6ipY85IzfMMSEulCgMJMWBjFKRl0lIZ5LyAptQv+g9HYwMgmY/YCPH5+0CaRuu98PLb+huRdpF2rnJTDNVw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(38100700002)(38070700005)(7696005)(122000001)(316002)(110136005)(54906003)(9686003)(83380400001)(186003)(71200400001)(66946007)(76116006)(4326008)(8676002)(64756008)(66476007)(66556008)(66446008)(52536014)(508600001)(5660300002)(8936002)(55016003)(6506007)(26005)(53546011)(33656002)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SriBecc4gZwWKYMNkRn0/1URlgcvscDx1nMxiesbkyBgfPxT/hlYz/GyN73t?=
 =?us-ascii?Q?t0afMcZiG/szlLO3FeYVvJxt5RJZnqPkh7fm1F5wF7dg8T1bs9MTYPvvaFPh?=
 =?us-ascii?Q?zh/Bru3PSE4vfUI6xTzxkJq1h/i6ZbzhPg43YUg21Lvc6b7jxlFVhAhGDc++?=
 =?us-ascii?Q?fkQ4pA3Ssn+DLkswixDqbRky0KwQIyE0czAAx2+ByFvG8Fy8JEFnYDnRfNa4?=
 =?us-ascii?Q?fj1vYEq1EFF0D9i9r5yVKjS4Evr0ABzpSYNwiVuQZHgLO11FPrvMsPpZJTa+?=
 =?us-ascii?Q?ygs8OAPcTtt83pu7pes/U3lASJ8GzSS696gMIYi8tDWmzR77hEVVG15EFtgF?=
 =?us-ascii?Q?HWpqpDFFHRJL17gALxAG5sB5IRNM/ZsfpaZHQ0U72zG1Qr/NcLt+c5ZCvH4q?=
 =?us-ascii?Q?r5gzNxD6J7/XJrfc70ynaXMX5K+REU0aUgPsirfDqEQ1ePD07GWKL6jD5wPh?=
 =?us-ascii?Q?splm8y9tEp9bhcME29XGNTr80RIn79cyfMkbd4H89jSFtdzTCRkNmm6gH3q4?=
 =?us-ascii?Q?SlVa+L5kbMD+sCfMxiLP+GY5ffFOGJDhjSIK1nsbZ3/H8S8+7U1ZiHrbnIrM?=
 =?us-ascii?Q?9QPXf2ui361q5MZScRCzWbd2n+uaQ/1s5Rs2T39UDP145A0um8v4gu908k5r?=
 =?us-ascii?Q?syFed35XWtqlyM09R7cjlnSErtfpZWr6hjLkzU9TTRZAVT79exbzS0FhPf9r?=
 =?us-ascii?Q?XxKOcW7UGpEznJ+rk2E9cO0Pol6G7UpuvCE1DSrcv96eL2Dec6RrmDS3CZg9?=
 =?us-ascii?Q?4CJJUmClDlHO9kJkrfDpZWVeTpK80wB3pdAtSbfchqA0GSnxFoWHjFF2FOh3?=
 =?us-ascii?Q?VqrIO4PVfgCNm83ueC9DdQpwq2tdVv+8+VKlUobqjS+sTubck0L0OSfB+hnr?=
 =?us-ascii?Q?YQVUrWZdhWQ20FzAy3VlmcbR8mMx4fXg74Pa7jDviisFxCoWdorHVHPprRr4?=
 =?us-ascii?Q?ch4S/8OfxtnLXkXQ8J/6toCHv346tMzs1BtgFVGs6dg78EEaW5RwK35dukN1?=
 =?us-ascii?Q?SMKd9RuX5dcFXusel01LcUDoSXvs0cl+oYRu1f4HorIu4FbM8zH+fIYu2UU9?=
 =?us-ascii?Q?n5YYTmdyF5bZebDUmjYXrkdziZ+KcBJemnEK2xvb6iU7TcHG2u3RNOgM8yDR?=
 =?us-ascii?Q?kXBFudoWB7P0/TSDhESbAYNTi8m/Fzg6znLKs1Z2eItv+CfRJOj6+Vl2l9ex?=
 =?us-ascii?Q?BfeHGGr1AjxXMP8XMB7bWNIzzj9PIjajUaYzVaqY3mroyGIj+2sBQ42VXRZk?=
 =?us-ascii?Q?btGnxHTBSdT9fnpXXUytq6F8dXDiwOKQN6OIQvxGiPBFYxUNKvD9oSb49GXb?=
 =?us-ascii?Q?onv8/jJbASj3AkguZKtIwTRAuJtXdczRqevhbqYNxBVUY8nPZF0wh0/IPPkW?=
 =?us-ascii?Q?Hd0nnWZeglz763Kr80eHkTjEMdLfQICen2VynAzYgau2J8wXtmPF/mHEclp+?=
 =?us-ascii?Q?r5zDYxFzMLYGexVehYs9VdZVy0GBCztvxwgHM7usinuxHfTBnVKD7NUzHggq?=
 =?us-ascii?Q?shA6Wn9CbjJrnY4luyyf0axBnIr46gS4bItgQ3PrtDR5JXc5DknJjizl5jtF?=
 =?us-ascii?Q?OMXazCusYFvlGH26p+VHJqbRfvGnFGAE5zOS8pT1BtPeUTP4Pgzmq8vU6B/c?=
 =?us-ascii?Q?bW5ngLkOm82uGZJhSwU2NMbuD1rAfLIUCRDGlYkxcON69ng4uitZOU8Ks9og?=
 =?us-ascii?Q?bnpK5io0OjQXWGFf3rbHp0pKX+B/jKQhyuDeR15bJK+2D2qw?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b5a920-3c35-4575-b8da-08da373f370d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 13:23:07.2303 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KnDAfaL2Ig237x6Gp2rg3erV4NJr5+TyKdruhDR9peLynDL8vZxVAmYA6cxPMse3hk/Sp2n4GSqkB++acqvVvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4705
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
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, 
 Wayne" <Wayne.Lin@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>,
 "Gutierrez, Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac,
 Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Hi all,
=20
This week this patchset was tested on the following systems:
=20
Sapphire Pulse RX5700XT=20
Reference AMD RX6800
Engineering board with Ryzen 9 5900H
=20
These systems were tested on the following display types:=20
eDP, (1080p 60hz [5900H])
VGA and DVI (1680x1050 60HZ [DP to VGA/DVI, USB-C to DVI/VGA])
DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz [Includes USB-C to DP/HDMI ad=
apters])
=20
MST tested with Startech MST14DP123DP and 2x 4k 60Hz displays
DSC tested with Cable Matters 101075 (DP to 3x DP), and 201375 (USB-C to 3x=
 DP) with 3x 4k60 displays
=20
The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
Changing display configurations and settings
Benchmark testing
Feature testing (Freesync, etc.)
=20
Automated testing includes (but is not limited to):
Script testing (scripts to automate some of the manual checks)
IGT testing
=20
The patchset consists of the branch amd-staging-drm-next (Head commit - da3=
8a66ac46e334f198afcd1b4d4554b4ddca0df -> drm/amdgpu: Ensure the DMA engine =
is deactivated during set ups) with a selection of patches added on top of =
it. This goes for both Ubuntu testing and Chrome OS testing.
=20
Tested on Ubuntu 22.04
=20
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
=20
=20
Thank you,
=20
Dan Wheeler
Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Qingqing=
 Zhuo
Sent: May 13, 2022 5:17 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.c=
om>; Li, Roman <Roman.Li@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pi=
llai, Aurabindo <Aurabindo.Pillai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>;=
 Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Gutierrez, Agustin <Agusti=
n.Gutierrez@amd.com>; Kotarac, Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH v2 00/11] DC Patches May 16, 2022

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
=20
* Improvements in link training fallback
* Adding individual edp hotplug support
* Fixes in DPIA HPD status, display clock change hang, etc.
* FPU isolation work for DCN30

---

Alvin Lee (1):
  drm/amd/display: Clean up code in dc

Aric Cyr (1):
  drm/amd/display: 3.2.186

Bhawanpreet Lakha (1):
  drm/amd/display: Fic incorrect pipe being used for clk update

David Galiffi (1):
  drm/amd/display: Check if modulo is 0 before dividing.

Derek Lai (1):
  drm/amd/display: Allow individual control of eDP hotplug support

Jasdeep Dhillon (1):
  drm/amd/display: Move FPU associated DCN30 code to DML folder

Jimmy Kizito (2):
  drm/amd/display: Update link training fallback behaviour.
  drm/amd/display: Query DPIA HPD status.

Michael Strauss (1):
  Revert "drm/amd/display: Refactor LTTPR cap retrieval"

Nicholas Kazlauskas (1):
  drm/amd/display: Check zero planes for OTG disable W/A on clock change

Paul Hsieh (1):
  drm/amd/display: clear request when release aux engine

 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   3 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  15 +-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  24 +-  .../gpu/drm/amd/di=
splay/dc/core/dc_link_dp.c  | 248 ++++---
 .../drm/amd/display/dc/core/dc_link_dpia.c    |  19 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   2 -
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   3 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |   9 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  10 +  .../drm/amd/display=
/dc/dcn30/dcn30_resource.c | 516 ++-------------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   5 +
 .../amd/display/dc/dcn301/dcn301_resource.c   |   2 +
 .../amd/display/dc/dcn302/dcn302_resource.c   |   2 +
 .../amd/display/dc/dcn303/dcn303_resource.c   |   2 +
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |   2 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 617 ++++++++++++++++++  ..=
./drm/amd/display/dc/dml/dcn30/dcn30_fpu.h  |  67 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   7 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |   3 +-
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |   5 +
 .../amd/display/include/link_service_types.h  |   6 -
 26 files changed, 947 insertions(+), 633 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.h

--
2.25.1

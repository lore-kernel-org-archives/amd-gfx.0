Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEBDC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Feb 2022 16:29:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E2510F829;
	Mon,  7 Feb 2022 16:29:01 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE3B910F829
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Feb 2022 16:29:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUj49PmPMYhDXgEM4pVK19JnX4xvAAs44vhKKSpJ2OqGnIY39ticHhzwSmJtpdSIh4zG5JOQXvKzbrK7cS0OIIt3c2n7RDSyOCmLQW7h0egbgO4nEqvD6o2GegX9DgXp9H7FJMQ1v+eBzMJmjNS72gDBMJbMoSaRQ9sx3vurDwNXIvzo0SMCKROwmc7pdRWJ07EK4Ruws2SyFeliDgbAbxMKr32avEX/I8/WWP2oZa2KyUACtTd4xvL4pSZobHZcxYTqHEETJFzb2aHTYcA91FQQAcbd1IoxUB+meRuBHjbJdIziThyQL5j/OQNn2+7OCaskGKEtgDwdicAaKTbuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQzY9F0oEgFIKRE4PzF6dxhWoJbxKN7WaKk6h+WmQkc=;
 b=IOzz1k4M/clmlkWnDZqkOoK0PhhwJ39StO5Ork6Hpaq2sT2CeKSBhDGSJsXwL7KSnJ8Vt/Q/18YdZys/oLqGObIzAM4JoRNBI79MlvuIyLV5QWEynAtyswPGp9c5R5Z8JBF8I748ULRJVXEatd3rwk1rdqbs2a7Xo6MzocZFvGJV7O4j8dIjRHGe/djvrZfB+5UvwQuIxSwA/QMxIbT+sDpt1kQz0g/lLeQuQEE6FCSh5+Fxf+Lthzg/CsQ30BUydcxokdzLjF+aCRd+qNr2+9fy5vgSVpR+y0N9Mz2dc0QFrNB9345RzmNdpcdJRx9YqVbY6+Ow+oiY6v0+JVJqtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQzY9F0oEgFIKRE4PzF6dxhWoJbxKN7WaKk6h+WmQkc=;
 b=julqCcl3GC+Ewa5kaqBq23ysh/mGa7q5j650n0Ik8q7mqWjT5CvPCauxgTeFKNyVbi63JdsYlq0VhiYp2RircfcihzpIl6bnwa+/PcMnyKwUChYmhTgqjQeWgyxxOSPGGV+UkW/K+StUn87LCpSuJ/hsc8s2hrBEjx+4EcB0Gbg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CY4PR12MB1142.namprd12.prod.outlook.com (2603:10b6:903:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11; Mon, 7 Feb
 2022 16:28:58 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::99d4:4d4f:653f:61be%5]) with mapi id 15.20.4951.019; Mon, 7 Feb 2022
 16:28:58 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 0/1] Revert Patch from Feb 7 2022 Patchset
Thread-Topic: [PATCH 0/1] Revert Patch from Feb 7 2022 Patchset
Thread-Index: AQHYHD8U6YW6GWJfrUqOn8qqxjSyq6yIRwdt
Date: Mon, 7 Feb 2022 16:28:58 +0000
Message-ID: <BL1PR12MB51441DCA39B3A6FBA4A7CCA2F72C9@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20220207162325.37401-1-jdhillon@amd.com>
In-Reply-To: <20220207162325.37401-1-jdhillon@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-07T16:28:57.577Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: d77e0ce0-127c-bd69-6cb5-b39908424a9a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17e090fd-1e1b-4196-9cdf-08d9ea56f128
x-ms-traffictypediagnostic: CY4PR12MB1142:EE_
x-microsoft-antispam-prvs: <CY4PR12MB1142E77641F8A7D5FDD9412AF72C9@CY4PR12MB1142.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SrvmwJBSDZXs4jAJhOqlhBL4zPOy9XLdTA7BNR4vU/+lVu5FoY0+FyqD0c8wRRSDqve1KKqWv1UwhDbgD/S4LdtAYomDneqUvZ7hIi/3J+hRjO79lG1UzOYniFfyQd+tj1cA7xKbwNDpJl7vxD+cyCMYgLCClz5wmttmb1oaarjSAtP4wVlKb/PRZiDgPWvcGP9BIxgzJ/IA2kx4hCcilmxTSBdIs7YohAmsRygvDC20IKKPWDNvuuPJqsMHyYZQshxVkA/k2DF9foY8kW28qupC+78+t/4lVeUFGBtpEIMQN7oSWdgm+fLgJgjssM1BktEtRmv5Ah4k64N+BcN9fGnxVHHJ2ffc692vlY0P48Fc7btGGBR0jobXx3VEfAI1VXjz/dlkkWAFCeRRvg9N/vjjHcFbkR8M3zSK4Vm3uGmTEJhCxoIfQ6W30lMj/+NMjESU1TyQcy06eSrrCN3UsuTAt/ll0D048IB/bTzAmzkXe3h09AwIupq66fBTeSmwUTAAuAZMyCVzzEGgG4tEy5NASEKeqgcNqUXq7kR7j7KeOsIAtWix27sBeU6XwrWSlaLyoC4AOkJtihZJVD2AByCDefRYCxeqkDgS2UQXyVWUmkzNvJX2oXMCGF6+ltspNZdM7Ce5tSj4MMu7l6XGaRINPhU/By8/+s8XSoj+nx0P708/ANA6Po+TpZHyriMhOXd0U5Wkrr0AYKJQ0mQQgg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(52536014)(55016003)(4326008)(66556008)(33656002)(8676002)(66476007)(64756008)(8936002)(19627405001)(110136005)(76116006)(316002)(54906003)(66446008)(66946007)(9686003)(508600001)(2906002)(53546011)(71200400001)(5660300002)(6506007)(7696005)(38070700005)(186003)(26005)(122000001)(38100700002)(86362001)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7UKw6YRj2DeqzW+Hoc3KZib7abYvJFc2pGiBXnBjGsR+bXrUaqZpNMqkC1cd?=
 =?us-ascii?Q?t+2cMkN11f2MLt7v61PQc6sp7padnKc0DOPVd45tVhMeQSU+PSWIaysIPASu?=
 =?us-ascii?Q?7p0/BH6Br8y3DLZTuqML6BbEtp+Xjh3YhhNAZNQ0V5aagsC38gtCbffyjcxd?=
 =?us-ascii?Q?py0gBQIthFt7YvhfikHGLxGZRe+C2bIcR2K/OHfXJxB97cw21zgOuNYXoZ1y?=
 =?us-ascii?Q?bH1GwKOA/8VGrVwtmez33OVhlFHpio/0KPBfzivUbHyZSxS1CdtLDHJ5HYtx?=
 =?us-ascii?Q?a92GXAcePbS6MKiU8BWgeqR/OoDOHUZUCtyeC2iwd93BapV0vC+iXjhSUeR/?=
 =?us-ascii?Q?kJuEhhjt4Q0keurrvuqTyJAGYP64s7USIPc/MMKIyEpkrY1eJn3f9MiBgo8i?=
 =?us-ascii?Q?kBKhYgqI97c6rrpfwkxvPjZyZUOraao7v51vdysBDhHRxs/sAJZzbaZpaz46?=
 =?us-ascii?Q?i7jW/U7JENQP2Hg26lmJRU1VeIe84WTi9xQJn5PK46F4Lgn+Y+8mfiVpz2Vz?=
 =?us-ascii?Q?kwPbkDuOm6rlpa+G5JDmoaaOWcMbWboB3jkUKoJwm0DG8dCedpf+Nb4xw/zS?=
 =?us-ascii?Q?eX1Xclq30YJG206JxKMjH6rBxU8lcmPiDVIinlijxGi1oHLGRH2KpaNGFBMe?=
 =?us-ascii?Q?Aslb3jgR9DL7Ieav2D5On1Tc7pzLfiJO8PqDdpt8MEiK9IOylA4wAMZCJKxD?=
 =?us-ascii?Q?tXFfm3vCHeqN0v3wXgPmN8qGzYd6svv5ykLGNXPgDX782HMDDj1AKZQhQv5u?=
 =?us-ascii?Q?uGKXYdxk8GG6O/OklqdxEc/fvWelxydvWOsnYZ1OjtOTiSYYXP49mjjQdhhm?=
 =?us-ascii?Q?3bMlsMm7vq8hQiXBpcIzgox8VVp314QZ8Q4XV4lYLhHkPPMF+0lf+PghMbnx?=
 =?us-ascii?Q?wa5mqSDc/dEs/TSxVGrO3a204dGwsFUXAqC7l/SuzfTyggoUlEfBKUdLFyD+?=
 =?us-ascii?Q?rDlb9KvBv3OieugJMedcx31K3RH/OOQ9j3/c/BbjKWfJEVpMJJxebYwZtvdA?=
 =?us-ascii?Q?ItZuK4cdxI+Tq/GkVP9IHUY7ckAhiIUC0N/gqdBdl5x7oJQbwFq3tXO/kqiE?=
 =?us-ascii?Q?yz4ucDZnhxCkrldfj1Tg+q5nGQrNP/lqPC+e3fGIbZzed+A6fdCAwtVH+5VR?=
 =?us-ascii?Q?oVT2V711pBQyhhdxdJX+2/V+uJOkvGit/ZuWVHZIVqI+04QtseMrx1XWowgz?=
 =?us-ascii?Q?EebWfZrVjMM5ZwW604sWxSv3k3UCHFm59CH7pMvyJ+pcLV+b4GtCVkbqWwZV?=
 =?us-ascii?Q?GBwFZNIDWKT8HGkiJahDAhUy5DusCHM5XTaNYbrISTTnPIQoG2t59YP3aWxw?=
 =?us-ascii?Q?POem+iPo2njcdAJbjUiaDT3C1OaJWG9x8SHvzLH8RS8emsow4ki+djMQSWEh?=
 =?us-ascii?Q?hWXs2cf/9n1fXPs6MLtGc1UDtvTFDzw+0xYWj/v1mqba0tuDKo6revEtuu7W?=
 =?us-ascii?Q?kKmTm+M/pi7nc8IV6JD1uzGxbZq5SW0cMnzLqReLYuZAn33/2md8d6TaPBEK?=
 =?us-ascii?Q?h8SWL6CEEh3AFiwhFxqE4w+zMCHz82W4fY7SFILWf8j0s4FepGMZjdXyEWK0?=
 =?us-ascii?Q?umLAzTTfL/kgf74wm1Ek1gjk+RAkExf4vRHnEngHOWpZ6ovslxSUjexUsrBe?=
 =?us-ascii?Q?rgCRDgSYeskEGDWbc2+5z4Q=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51441DCA39B3A6FBA4A7CCA2F72C9BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e090fd-1e1b-4196-9cdf-08d9ea56f128
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2022 16:28:58.2599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guzTj9JvPCsd38tx4NpOwiVHzBXkQhgr0zqsl++w0J5NpwLdPZnE6CoptGF5sG29ft69v7xU2l9hD5OZ8Wa+HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1142
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, 
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Chiu,
 Solomon" <Solomon.Chiu@amd.com>, "Pillai,
 Aurabindo" <Aurabindo.Pillai@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_BL1PR12MB51441DCA39B3A6FBA4A7CCA2F72C9BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Jasdeep =
Dhillon <jdhillon@amd.com>
Sent: Monday, February 7, 2022 11:23 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Li, Sun peng (Leo) <Sunp=
eng.Li@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing (=
Lillian) <Qingqing.Zhuo@amd.com>; Dhillon, Jasdeep <Jasdeep.Dhillon@amd.com=
>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@amd.co=
m>; Chiu, Solomon <Solomon.Chiu@amd.com>; Pillai, Aurabindo <Aurabindo.Pill=
ai@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Lakha, Bhawanpreet <Bhawanpree=
t.Lakha@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Kotarac, =
Pavle <Pavle.Kotarac@amd.com>
Subject: [PATCH 0/1] Revert Patch from Feb 7 2022 Patchset

Reverting patch

Jasdeep Dhillon (1):
  Revert "drm/amd/display: Basic support with device ID"

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++-----------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  2 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |  3 +--
 4 files changed, 5 insertions(+), 26 deletions(-)

--
2.25.1


--_000_BL1PR12MB51441DCA39B3A6FBA4A7CCA2F72C9BL1PR12MB5144namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Jasdeep Dhillon &lt;jdhillon@=
amd.com&gt;<br>
<b>Sent:</b> Monday, February 7, 2022 11:23 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Wang, Chao-kai (Stylon) &lt;Stylon.Wang@amd.com&gt;; Li, Sun pen=
g (Leo) &lt;Sunpeng.Li@amd.com&gt;; Wentland, Harry &lt;Harry.Wentland@amd.=
com&gt;; Zhuo, Qingqing (Lillian) &lt;Qingqing.Zhuo@amd.com&gt;; Dhillon, J=
asdeep &lt;Jasdeep.Dhillon@amd.com&gt;; Siqueira, Rodrigo &lt;Rodrigo.Sique=
ira@amd.com&gt;;
 Li, Roman &lt;Roman.Li@amd.com&gt;; Chiu, Solomon &lt;Solomon.Chiu@amd.com=
&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;; Lin, Wayne &lt;Wa=
yne.Lin@amd.com&gt;; Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;; =
Gutierrez, Agustin &lt;Agustin.Gutierrez@amd.com&gt;; Kotarac, Pavle
 &lt;Pavle.Kotarac@amd.com&gt;<br>
<b>Subject:</b> [PATCH 0/1] Revert Patch from Feb 7 2022 Patchset</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Reverting patch<br>
<br>
Jasdeep Dhillon (1):<br>
&nbsp; Revert &quot;drm/amd/display: Basic support with device ID&quot;<br>
<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 ++----------------=
-<br>
&nbsp;.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |&nbsp; 2 +-<br>
&nbsp;.../gpu/drm/amd/display/dc/core/dc_resource.c |&nbsp; 2 +-<br>
&nbsp;.../gpu/drm/amd/display/include/dal_asic_id.h |&nbsp; 3 +--<br>
&nbsp;4 files changed, 5 insertions(+), 26 deletions(-)<br>
<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51441DCA39B3A6FBA4A7CCA2F72C9BL1PR12MB5144namp_--

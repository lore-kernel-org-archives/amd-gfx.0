Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FBFCC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Feb 2022 15:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A55E010E45C;
	Fri,  4 Feb 2022 15:04:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECD0010E45C
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Feb 2022 15:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y64ZEUVOmqR3CZYv/kPy64QyQA4qsKZaLvuVbYakGO7SSz0o7OlOGz5evzdBTEQNipBp1MMWiyP20626yZblSfWyEJsbRqT273bd8F1K4YCX53BrqJrO0NyhXipvSJ5sX1EeYYN7oLoh/V6QyYXnNI81m5T+IiyB7fa97j0+oWsNp3t+a45O00wRPR7TwmpWNa5PNGGu7DgB8IB/AgNn5/zu9qu8D1ATAxP54JDj4UG60bDDbWgdg2N7NQUEDgRMC7Zg6NOoky6rLCOM1wMxhxVjo1UigqlIaRQ/az3oK5D+QDRQ/0/QYHxoXBFSYIFAlqlEwbMv2kbAEaONycl6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6IvkPwM1ruGrTBRBUzlXQ2Zmkp+qj5JCxPxJUDY9gE=;
 b=BPaQhYOP3wl/uJMvWk4nWufT8IwRgeCO7llVKSR0BiBxo6l6hckU+SfxR29ZLLj/7rFm7LDCdb0cpycYnMbJacPQhz6APgbuI2SVr7ku69XdykMhggUiWzzKdqYSxYvwePjQfRZzOHVCPaRZqG5t/Akr5XONLLuARTD8YyTbRLcOuD4WXoJ3V+7ia5c1uGNrLqhDGs/EhqanHajQN+z9+BOLG+6JVKh5IacmFx4oYADepsTCzJGBwxrQVcUMg8EBn5o+ZLZxjMvVfy0RzWtA0Bg1tJGklJg48mX/Rv9UG+5n6pP5KbYDeYVhklwTqe6k7XBXaik7efjoSH45SfiZtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6IvkPwM1ruGrTBRBUzlXQ2Zmkp+qj5JCxPxJUDY9gE=;
 b=LBz3bKRal1AJES2vVfl82Ju8taBRUrdTHKwCY9V8cVsPyaM+M91QJbDPeVxvSXcg6gIykI4C8NChkDG+cfcTlC4op8qggGFodjrs6gViKH67TUTK5NYLY/L4CQtVVZ0cAT1meHj3MrSHnx5Xb/SGimrlyN9OIwomeTTbmGdA1vc=
Received: from CY4PR12MB1303.namprd12.prod.outlook.com (2603:10b6:903:40::12)
 by DM5PR1201MB2507.namprd12.prod.outlook.com (2603:10b6:3:e9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Fri, 4 Feb
 2022 15:04:32 +0000
Received: from CY4PR12MB1303.namprd12.prod.outlook.com
 ([fe80::996f:5c79:1e41:85c4]) by CY4PR12MB1303.namprd12.prod.outlook.com
 ([fe80::996f:5c79:1e41:85c4%9]) with mapi id 15.20.4951.017; Fri, 4 Feb 2022
 15:04:31 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v1 0/3] AMDGPU FRU fixes
Thread-Topic: [PATCH v1 0/3] AMDGPU FRU fixes
Thread-Index: AQHYGYfvaL4BdxIqWU650rN/gE5zgayDfbug
Date: Fri, 4 Feb 2022 15:04:31 +0000
Message-ID: <CY4PR12MB1303E7B55D0F590CDCB7276A85299@CY4PR12MB1303.namprd12.prod.outlook.com>
References: <20220204052724.469469-1-luben.tuikov@amd.com>
In-Reply-To: <20220204052724.469469-1-luben.tuikov@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=5ae0ed29-1bc6-454c-8c32-c7c6067a74bd;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-04T15:03:41Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2999bad9-e0f1-4a0a-9802-08d9e7efa61b
x-ms-traffictypediagnostic: DM5PR1201MB2507:EE_
x-microsoft-antispam-prvs: <DM5PR1201MB25079BDB5BDDC7FF2DCDA86585299@DM5PR1201MB2507.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:167;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tv5lLDLTNmin+2O/dWxJLKw3iY9vX67VTOfgbJdDa3iFpQMbo5B+pzNxHKgYrczbbs44n3ykuwAhQOPLwlHyWEdhccS7aBsU6yLIxk3kGShurTXvl7kBmbrlizM7RUiiPrMpSg9imlXa3P6uSRQ0+pTNr1kRKFg2ak1iEAmhCEIzQjsfBuLgn4uswWNEPFfIsKRIKU4LFlN8smb8ssbEf3EZmgbXkGg0Q1uopsmCEea+qAb9iQY3ZqXvsnw7+ZHVi2ZOzuRPC5AN4syZnVS53YuhW1Bf4wsGo2WEk0CjccsHF7julhXV0JAflmiuLzU5ViU+UWNO3ikqYbxoO+ODF1AMKxjLzvvCLEDyTtpCKhuIbcY3PIkpp+xXczgMeCjluZVEw896ISVNh1CevKv4Elp7Y2Ni71bJOQ6n70N0ks0HQQK6SKRPNLBeQkcxfGKJRWoJtSRlq8Ka1PBU1Xxd4Mxsp6byv1bPUQM2C2w6uUTivqSmfRu/Ja+IXsIzo1LQMlNb697IJMYoxeMRR4i6BgA+bZahZ7hMpo7O8kkMRxa/RkyS+y0rKfdn0DTTYVnk5SZsPuSIP2xic0WGs+cYvnX7SSXsJdoQRTT3xsLK4wbyfpPX2YJYhUARMiMqptB4TD3aq4uL3KGUw1VDhnHMeXGl1WGLWlPTIDgFy5ZbCSt/vtsuBTGRCII+W3QHRCdVZ2ENlgfEOIUFUpyUf1ThcQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1303.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(33656002)(83380400001)(26005)(316002)(66476007)(110136005)(71200400001)(54906003)(9686003)(66556008)(6506007)(4744005)(66446008)(7696005)(4326008)(8676002)(38070700005)(2906002)(186003)(64756008)(508600001)(8936002)(55016003)(53546011)(66946007)(76116006)(122000001)(38100700002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fg/SIjfs5ijPQ154eygCq9PgkQopZR6w7NIXoOM5zNFwB6OyRXTM2gcyDeO/?=
 =?us-ascii?Q?7Zx5tpw+dW2F2JBhnOQt7VvehHGbj3276pxxAk5v6LwHi2bJhX7rv0F57fOb?=
 =?us-ascii?Q?xnzybV2SJTB6XX1oQrAERlXyJpMtWdELgmxWoRIomw7KV09dE/9YEeHDcrIw?=
 =?us-ascii?Q?A8nCs68NyZpX6t3dyVn03IScfDQ/HIOcZkdytm3sNvzLnS3G7UfgoW55BW6k?=
 =?us-ascii?Q?GmeL3insGY/yR1vqCWYOFXuDNH8coJEp7yGVJSkS2tUDsVBTqmN3hdyL+VLx?=
 =?us-ascii?Q?RAKWhRZC3qe5vTNuG3yWmwtGpZIE1dvVS3HbwaD/E3DSsAmNPDJ6Xl7vzmDX?=
 =?us-ascii?Q?q9bQNAk01ZBTEcL1gQKITmDY6V97HlvmTBJ4tnFjuRuVdmFLrnBDKtIqMTuO?=
 =?us-ascii?Q?N6rg81kpe519NcXrN8iwliBbCNc7V7VrT316MukpTJ/TUoe4Hq4UCvXpkX7C?=
 =?us-ascii?Q?TYKURi4ZQq2QCOge/X0hlQI2wOLRoq39sLv1dWFbHK2/iQN3ux8jstLwONrj?=
 =?us-ascii?Q?08317oJ/ujSjURLxRKw2LGyg/bLivZIs2RBVJxmdl9eqF5luckCc3cqrHSP5?=
 =?us-ascii?Q?M74lVbI1TEEyXz7GyOSyCIS3x37BFrYRhuEc3fb94FqLW7PS29pzvxX93zA0?=
 =?us-ascii?Q?uW++hL9xT4+el1sQ4vfyGIySis5Kwvp7EdBxEeu7rdoeW+DP4i2hN7uEvoY8?=
 =?us-ascii?Q?PUMnffsf+GEvJSCaH5WXekNQ0sNdF/Y/xn/yw0vc+pFDPedbpJ7gQDue3xdl?=
 =?us-ascii?Q?mnsAmtw0izUNeAGTmZbBIfjbicFiPbXOKdCo0zZUDN5HeAYeRDf/UDlpXZaE?=
 =?us-ascii?Q?PiR07E7EsV9qySSSfoDcw6xDHdY/itC9GzQO6mwG1jPnYvb4D1QVlg3t5XbN?=
 =?us-ascii?Q?gMWSJHUmg5/K7LTXIwtIJkkBpCG/MFQmWx67zCHFGwmjEsgpPwgk2Usqyrud?=
 =?us-ascii?Q?MIec9c1GtQC/tDUFnJo9vTZPc+QB9riC8ncL6K8b4BxXJYp12Mr+HuU/4Mkh?=
 =?us-ascii?Q?hh48Q7ly+DvPpRVBSDGxYT1GBamxMHRFlq6DWphaKUhGEKKID7UmameeaiUA?=
 =?us-ascii?Q?gk7c8p9hfi7bgf1YVWPE7MjhFCszBIVV+XFBJLL2XlTNS+eOF+5xmlLdXysU?=
 =?us-ascii?Q?1oXxk4utkvgL7SReLez/Jdzwk7gE+Uew7YUfWymoZfx161y8XLgYZr1Wb9u1?=
 =?us-ascii?Q?QWKuvCUYlSsV5dXTu8czRKdDAql9v6RT+WN/bNPW5SAsjze3x3bSUR++UaL8?=
 =?us-ascii?Q?xeHqQgXHUzS8+HdjXg1jb0XM9ZPEJZxgZVe43/DmG8AAwEu+YbGt91xn0Yp0?=
 =?us-ascii?Q?lPrGKWf2C7KqLyxyTHaWIeFBWbeWgdAjg7AzrTBjAyXQ8+rD6kg18L2w6I1p?=
 =?us-ascii?Q?39eSNA9AlRkKaD7FQSTx6BZIRUE0/NOJOwbHFt7dqgqbuutyySntQalT59gr?=
 =?us-ascii?Q?5Olt4vNrFn8xri/9AUs/M3gqghwo5JXOlEt7p5BUnEeNzGhsuYDvnxg2JDS1?=
 =?us-ascii?Q?JrW3PyImp0O1qiGFUuZfc2qTti+Sb9+eL/JwRvmZVaFJHMtMPkCBH3Fmca51?=
 =?us-ascii?Q?ZZde+wRhbL+10JDxublibIx0wJYskGNG3b4l7hqf9khx8UZBxJIalk+4lfsk?=
 =?us-ascii?Q?iA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1303.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2999bad9-e0f1-4a0a-9802-08d9e7efa61b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 15:04:31.8880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a9lbJhjOLwHOg4eucqCJzxUtOoyw+s3UJ0gV5UNb/E6sJcOaaOayCmrHjiglnsUTDi9Bv04pOO45DSSIeM4NHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2507
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Grodzovsky,
 Andrey" <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Looks good, even if I am a proponent of "buff, don't nerf"

Series is  Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: Tuikov, Luben <Luben.Tuikov@amd.com>
> Sent: Friday, February 4, 2022 12:27 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Russell, Kent <Kent.Russell@amd.com>; Grodzo=
vsky,
> Andrey <Andrey.Grodzovsky@amd.com>
> Subject: [PATCH v1 0/3] AMDGPU FRU fixes
>
> Reordered the patches; fixed some bugs.
>
> Luben Tuikov (3):
>   drm/amdgpu: Nerf "buff" to "buf"
>   drm/amdgpu: Don't offset by 2 in FRU EEPROM
>   drm/amdgpu: Prevent random memory access in FRU code
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Kent Russell <kent.russell@amd.com>
> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>
>  .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 36 +++++++++----------
>  1 file changed, 17 insertions(+), 19 deletions(-)
>
> base-commit: af42455918c42274f6f317a88c878d59c4564168
> --
> 2.35.0.3.gb23dac905b


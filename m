Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1577EC4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Oct 2023 13:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC8510E4DA;
	Tue, 31 Oct 2023 13:55:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F77610E4DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Oct 2023 13:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X51HnrcqEGcg2XSaCsoWiyQPq/Jm2yWLE7IzWuhQpuvjOcQXrkQtNEsiXYzEbhSJpsGCSHLQU0olxve2lvlCmQVuQL6sYFVR3nMl1kZnH7vAV8LuAsA+tdQzj6Q3mlTifauaU4zGHw1F2GwfC5oimBfSCeu1Yn9qyIo0CJr1s80+ZAfIldjl+eDjlHAzoMxVeYDcs9Kqjfg9aam2Xbzch03COnU2X7gRWxV8KJpLAmACnuj256aqBhLAkN/Pr04PcRKz77/GlDnpS/CeZOx8xe0HfP8rD5+QGA1NbZ9hI37x8/G5iTKVqoWMxeuamsfGIJzDbVmLNulKFHdlITSIeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52S6Ak1ZiD/TZAT7mt3BsMuHYGR8d2G9BQjXRdb4PC0=;
 b=UfOawzLjJYiLA/fxBbAR3nNIrloRccpp61k7rTPWEp8a8GUm71hbVAjY4AmHb4hOHgb5ShTjQLelfvwnV4evsc1MuL7kdaw2x3iG6i5eehbDUllPoH0MwGrjtR9bHvPGHsYhpY0PyQl2bBchHYiPGDr+T3On0NXIB9MwsMau3K9rXkWffabhf4YfGJPFUIZ34coCKaGDNCis204lExZY/uLuWZgbxgXUEkYEZGoZX5OjQGwSdsha4dSIWM/aE/Jh9v7SB2KM/aodzu9dh7S5HcgGLopmCF17StTwPCS8IxgZhmNRjgEb3m0k/Zo1r77S0QPSuW5DfmebnCWN1TQv7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52S6Ak1ZiD/TZAT7mt3BsMuHYGR8d2G9BQjXRdb4PC0=;
 b=JSvvkC/uTfidrCXPV512/ihJ0prDadZx9EOKhj4XWz7Ugtmoln541IBheq5xTbE4qjgpWFYopurVEpN5gj3dL8kxxhFotDLg999yEZsSTJlcfH9wkHW4XhCdk28c9kPWGE749M3npAS+4MapF88nw51K3H2Z3RtivePghIUgt34=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Tue, 31 Oct
 2023 13:55:46 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::f081:16c7:9129:c010%3]) with mapi id 15.20.6954.019; Tue, 31 Oct 2023
 13:55:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amd/swsmu: update smu v14_0_0 driver if and
 metrics table
Thread-Topic: [PATCH v2] drm/amd/swsmu: update smu v14_0_0 driver if and
 metrics table
Thread-Index: AQHaCx+pgdA5xEDIpUue1ad4qFT16LBj7WwA
Date: Tue, 31 Oct 2023 13:55:45 +0000
Message-ID: <BL1PR12MB5144F4ACF742094CCFEA303AF7A0A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20231030105519.1961123-1-li.ma@amd.com>
In-Reply-To: <20231030105519.1961123-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8d0e8bd8-9019-4823-ac37-144a505f0aee;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-31T13:54:58Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW3PR12MB4425:EE_
x-ms-office365-filtering-correlation-id: 1feee952-4f18-42fd-3997-08dbda1914ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qPnvHP3/BsOdGiOIGA7p9/UFDf0PWX3RZUrtav5rg9sQBBnJt0Eb1AUbxhMbUY+PoNOfdmbNnpdHLJx/sUSl6rV5guvct/IkNSSjE1wa4edRAnngF/pkzda9NsEUgBEXt7N0JWc7EIiP+CqpQTxIvMhJDrUPer6DZNpan4e1ce3+uid85RXMMQDZpkGm7Hw+024Su3qZXl/lLn7ZoEKX8osga4v+mfS5bUn5HRqF2AMrLiknxcSqC6fOacd2BVVDQXj19QkHnbcYHIDd+QCp43E24woQQ/oGRKrtiTYR1w5dCuclkGTqr/8ZEzVzgkw++kADnBOENcy5k21aOlVEcWaqP5a6sqFDwNy/5k8i6/mP8kTVVaha9MbWfkRkYDXieJYvRvaczzx1tNDr+yd+yR8mIZ/CwGp419w12ImL3hx9EoTLPcuXZItJFwZppQyDN2lXfKmZwDmpodqEeaTAM5WfRgN7gk/d5mznaI9mkx80dfuJw6NIlpoUDashXZ1UnEq88+yyqp/brnUW18ey5QSktcgBrufDfsx7ikIvFH0urb1rX0qw6kFnFfEf4jMt69UtupqmlrwbcEBmhkebFz40B3mxXcbb8KNweohOCO2txS33fjtgBXnOTzUMky09u4Hw/Bs4MAqyrqD4uiSGliX9fv055TM5i+7U6VVY1Qw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(366004)(39860400002)(230922051799003)(230273577357003)(230173577357003)(451199024)(186009)(1800799009)(64100799003)(316002)(38100700002)(4744005)(7696005)(2906002)(6506007)(9686003)(15650500001)(41300700001)(53546011)(478600001)(64756008)(54906003)(66446008)(66476007)(66556008)(110136005)(66946007)(76116006)(8936002)(8676002)(4326008)(52536014)(5660300002)(83380400001)(86362001)(71200400001)(33656002)(38070700009)(122000001)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?49i+HqeVNEFRRZTCzfszOlLdqV+3IKfDRq2oo+1WmY+hwxx94krcelRgNpcc?=
 =?us-ascii?Q?+ZhKn/YJE6yOQ2bejwpE54lEOHXPw2D8+SQ+oMVMEoDajnLh8yAnYencrRpk?=
 =?us-ascii?Q?y18V7SyyJthrplT39MJfqhALA6nrzHjY79HS6TtIG+9+yAKUn9k8ozgWOkjG?=
 =?us-ascii?Q?z5IjMyE2mYUMIIgawAgltWU9Q4UZVQeDQnFNq5UrTiHyJGOBdub+RLagNVG8?=
 =?us-ascii?Q?wdL3SgJZaHc3rRs989EAlG1dU6KhbGid7GJmLEOoW382yG2nAhX2iVWkGc2P?=
 =?us-ascii?Q?FevFXSF4Kzu0JnVxvVcaSnjGnabpL4LRZr5fl2WGskv56kY+R9ZiG0VEOJQp?=
 =?us-ascii?Q?6oOVR1nr2GUMJ2MTARnUuL41Kp8VnXbIghFx5YCgiYUW60/TdELm3oUhWr78?=
 =?us-ascii?Q?qMXihvl+Pr/rByVsnSt+3OH7aNIVP/jOtE8358qI4yE5kzUV71gO+/HXqj8e?=
 =?us-ascii?Q?P+OhD8+8D10oK8fz7sHNhllXLuDq3UmYTID9E/xzWvAgoLdsldLEyDMoAHxI?=
 =?us-ascii?Q?GGSoxEYBI725dKz+ooUjpoH2r018l0glCXKrK9O8ENQa7MycQUWOnGvF87ol?=
 =?us-ascii?Q?TkN+JoVC3rwXuo7WsyF8ziO7yM9IXBQ1194vKlFjeqT18QTRVM6i5YoDWasL?=
 =?us-ascii?Q?DiJ0PRs1Jqi7GE56I1RixfM5ezx7vRov2zOMVF2bgbREURXmbFcN7OI0AJxR?=
 =?us-ascii?Q?McKjtyStGm1nf/b3DX45uCyPNjkANfbFzN9rw4POX8L90h24U1e37jwRuWSm?=
 =?us-ascii?Q?A5FPVu1tWyFZD7hnxnBi0M2E6wqReUkxWzSio1mS6sk87EWIPP6Z82akAyH/?=
 =?us-ascii?Q?cidGRlqDP37cZyR/QFCAPtibGS6oCfaj7rSWYp89UIjNza+vNDRVhyE+CRXl?=
 =?us-ascii?Q?xB3dFjAGNIwWDFynKgakm0HiuPvJ60qA6OTRhyZ4uGf/OHjOiFqICkgHvgvI?=
 =?us-ascii?Q?I+nSIihc+tjjel28EUL/VnOUtVmBsbF27Vpmcso353zRK2HXm94Zh9CGzHQ4?=
 =?us-ascii?Q?s04eBdsU1gj8N0MA8HPhxbrPgx5TJsOpVURhBAyzkkTqB8g29RXwAGhbjjzE?=
 =?us-ascii?Q?4aIqexnvE6Ll9ARG0WeqDgMYbSkm8tZr9T1OsyoZFohzkb15Cxzl7P+Ka3mT?=
 =?us-ascii?Q?Kn5NcsjfRfOP1bwGfbUw7G9xyyw+6ZijFstnUgVwFzGS2dXdE2bR/UBF/XJU?=
 =?us-ascii?Q?WD1bZXxtohjYOA9FeHfVxCzv9DUXPu1R6i9cfDthlwrjgoB7tmlPkB6HFrdV?=
 =?us-ascii?Q?L7gapst+3E9VsBUs3ZbexJx5QptP9nrJquqlhD1PUS6TAT/dut9mLp1R4/z2?=
 =?us-ascii?Q?fpdjNPTwJ98mISu/Bx10J4QrNOOeTedvhAkN6oGZPWAhsue3uWDxwdP7krll?=
 =?us-ascii?Q?XZwJfkzwq9ekyhwNvPaJxTzxcLWogiJSm7XYl/FVj71bO+8sDX6aqpnyM9KA?=
 =?us-ascii?Q?SJ8UdklxKt5LGPQ64k4CofeP3XHQEMgNU+j2B6LUsPjHYjfQuaayRufz+S4Q?=
 =?us-ascii?Q?bNtlEvVj98eIgVIbatTyGOfym92rg3rX/1dgcfc6XYIITuInYVVWHzeZ2Q?=
 =?us-ascii?Q?=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1feee952-4f18-42fd-3997-08dbda1914ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 13:55:45.8862 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vTccnxzD+Q+kq7mDLpnI95qG/ZkXcoBoIFF3zKF4dvO+7jksBx521fCg0J5KjU2fK6ZsdeuII0gwEgwNZyXWbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>, "Ma, Li" <Li.Ma@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Li Ma
> Sent: Monday, October 30, 2023 6:55 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Ma, Li
> <Li.Ma@amd.com>; Du, Xiaojian <Xiaojian.Du@amd.com>
> Subject: [PATCH v2] drm/amd/swsmu: update smu v14_0_0 driver if and
> metrics table
>
> Update driver if headers and metrics table in smu v14_0_0 after smu fw
> promotion. And drop the legacy metrics table.
> v1:
> update header files
> v2:
> drop legacy metrics table and add warning of checking pmfw version.
>
> Signed-off-by: Li Ma <li.ma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6631C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jul 2024 02:16:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5074C10E07E;
	Mon, 22 Jul 2024 02:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J978KiYW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D7410E07E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jul 2024 02:16:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gp+tLvIdg6qkPvObRBFOBA1xkTij5rIKKWfq5xONuxzp9op+MHxqxU24mqEjIWlX2f5drJnmya6VAksshh1+Rk/QwyPrJTjn/eLUGW6S9iFpR43YhIn1Nbb2Za+CPrkeSJgkyhEtq/TAhMIoDOgJ3lYLG2UPPaYrAbRyMeLbJG4n57EBm0og+vsaM09YeZElWLWmakZDY7Dt3YxiNsWb2TnHurgf3le7R2eTC3MDyJ03vq6WtJmjQmodU/Hqz6Lhj1hTjjRHHjCx88F8SPQmLFbzy+UUpiWcIXsbBnbV48bqAOH5RcYAYN7GLc5VupAfDUZgXjBZSkdFZlPOaj5OiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t32+YQb2kQ4/wnXuYrqOMXkeXKI3OSHM4H2dsD5S4yE=;
 b=ml41sYz92oIXUvyI7YfOqI59TArlAlq907KOJBv4zva+y6EBc99ulhHlk214RiCMfmQ1aKsHqCeWjIyz634+SYXXpOOE4UtnJ/NRf824VAQG7/VDUL2TpDcyGmMyA0Da+stZQFgpiPXdFU3rBqH5Nh7p6y3eGVouRBuSuW/XiUZFRtXtjulQCdCKNVQ3pFC7dFakIGmcm+3iqnTTiEIgKvGixvJS6V9vCuQ1HzZBNtm0NrByLP9rO/0jka6AYY0qfANu0Gc0jVXKTJwMLdH8aFeCAdhLi+Xm7LKR+33lRgtlz0QUbpRy62xObucR4y8q8EZu7djPkrOFNLVRxTTsYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t32+YQb2kQ4/wnXuYrqOMXkeXKI3OSHM4H2dsD5S4yE=;
 b=J978KiYWkKcIuW3YuyvmY9RuyfktXsi8kQePsiI/Qtwlg3/2YLnHbC+HKsGiF+mRxerWxSdrkahicAwrKoyBBTFipgRA+/zSeGc6optdGYpEAHpAvcPRxo8KLAtcPsHFrC55d4EdEB3ldcGIzAYO6IBG6uQYBi7poGZ0pK12ARM=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Mon, 22 Jul
 2024 02:16:42 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::c593:f43d:c798:e009%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 02:16:42 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang, Stanley"
 <Stanley.Yang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: fix ras UE error injection failure issue
Thread-Topic: [PATCH] drm/amdgpu: fix ras UE error injection failure issue
Thread-Index: AQHa29lAim9h7CXU9kKFvEOHuGgHJ7ICAgFg
Date: Mon, 22 Jul 2024 02:16:42 +0000
Message-ID: <BN9PR12MB5257F6DD7F4B21939D200C56FCA82@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20240722014755.1183598-1-YiPeng.Chai@amd.com>
In-Reply-To: <20240722014755.1183598-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=4dbd1892-3ebd-4edf-bd92-b3d2abf9ecbf;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-22T02:14:15Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|MW4PR12MB7118:EE_
x-ms-office365-filtering-correlation-id: 1b0cb175-33fe-4bd6-b443-08dca9f453cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?pQIwZhpsZRCxksz9RQs+MepIEajl7ahG9gOaAfdyZ874h8R3Mek8pWKx+PxZ?=
 =?us-ascii?Q?WNsoaH5BzMhmlSNXdb3MXzbA8RmzT4QCshrnLVfCDY6/OTO2ujrL3eMgMHk5?=
 =?us-ascii?Q?sTSA6kdW4E2nDQVDQXzpAF5hgDPsI80c7Rewl1/FQpu42fC56WAVQMK0YHNp?=
 =?us-ascii?Q?WLnInrseKH2aT1gHNbw+mkXlp649lyhXaJuHUDQxt9W1GrauFXfjhy18HEil?=
 =?us-ascii?Q?h8xUQI7VA/n71TjzisewOo0TGUp7P7nZYR8sCdZZn07UBwR2CUejvbDAlI9Z?=
 =?us-ascii?Q?mSsQ+Xn6bE8v8ktsYS44SF1/a1u+aao+Lp9mdVEN6+SUFIAPzsoyhtdoYS1h?=
 =?us-ascii?Q?k0KjhRx45Ki3PEbtkM0jZpU/zq8/AjShE+bU3kU11bVDm8mSuDZpi9fREmnR?=
 =?us-ascii?Q?S3i02W80gS4lcjlxu1OpzErnw7Ev1WPtVOP2rMSmnK5R3nBYUllN8QSI0eLB?=
 =?us-ascii?Q?sJkwtEXIJ3sMf9p9/laiTyqBhvNTiwLB9KeFMe+nHOlQZ8mPeGzHFYNQ9Eyx?=
 =?us-ascii?Q?UT0tYBS9aLsPZk1VHx79wOTXtsrSSaWqQlPlmPwilV6nQ0U4006EuJCiwM1R?=
 =?us-ascii?Q?AQ6ir+9sd3yAq5Q+NHVHkfIe49uEUBq4X8rC3kWUW/ygV6mtndOxMZnfU95q?=
 =?us-ascii?Q?m/JrTbeg3wfBpnyhGoMJppHJ7ped42T/M6GqSyzstswPKBVN/i4Lk1mnx7E4?=
 =?us-ascii?Q?JOoSvR+xOSA+OmQnUPi44bwl2EqVZaceii+tmH1lxu7zHY7Avkvo/7PgZ9n1?=
 =?us-ascii?Q?vWxpXGK3vOeyDPMTvhS57t8vMe9hVE84lmwtIZ1xCxd6CENeSqvaWRrt4LF7?=
 =?us-ascii?Q?R2KgpMJEOOMXik+zWGd7irw/A8w96sNCB4r80VBYqtDKxkcx3pfgrms8Mmwm?=
 =?us-ascii?Q?iKCJfQ+yhnNTMPLHT0X2RLed531lindVver70c4o8vN3iGDmKdrzTPncLmPD?=
 =?us-ascii?Q?eF9pGbRt6iWXExEu2YW5NkyF848lischYOYrdgvRME4dKI2wxWgKhLYo/3na?=
 =?us-ascii?Q?0pmKk5KAzjrp/eYwvmhpLJkqRWADAuYuA+OSJmQUl2X65HnwcgUqImJeJLEv?=
 =?us-ascii?Q?BSbPFNgr5MBfHgwOK878FVOgEjLtuwyT073UyW5XF3mVavprGzQtI+U020/c?=
 =?us-ascii?Q?lcajT9CIF4VzFrcq96t4BseVvhxKSDW63u1f4aoxMADPbKOt6sMQH+KwNKkR?=
 =?us-ascii?Q?XyHqHtNGHEm+yqDt4EBe2D4Jl3QZxP6M2/VdncKDZZx6IhADTTySScJEZ0Mx?=
 =?us-ascii?Q?sPlPOVwRe3aVtw6YbpurjWgkcKet0W/PeVNjIrZCn8aYfU0qWCXEqj4Hh1Oz?=
 =?us-ascii?Q?cN/J90jG3kqK220GFndNSKo5srUdKTtzuqKyaRYtRYt5dFF6rV9nqzBrN9QS?=
 =?us-ascii?Q?LuFDzW4NHXfGgdymu6G8WidOD1oO6vsoMEnQIj9UXqM/dPYcCg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qvmwte5i5qkHh/IaOX0iyy2v+1XvkINN7JsF+jDe4A35x2x1j8UHIaPdlJ40?=
 =?us-ascii?Q?5zNNAjQ42zV0/YR4AbEUk0egq1Ai+zsd4b9pl4Umz//atR94MK975eo28miA?=
 =?us-ascii?Q?ki8l2WdJ/v+zds+2DUYZxxRvxUfYJmDIO8VYF+OitzdjZBaNztFk5GFYa0co?=
 =?us-ascii?Q?7JhMr/S7po2GtfEdQrq+m98QXcrVPqaq+e1f4+zOcFh2lseurOsP5PnqVzlX?=
 =?us-ascii?Q?TSYvVWCncVG8alI0ExpU2Mg7YSsf5U3+JOtaYQfP8/TGgLpvZ4dkOp/NwqdH?=
 =?us-ascii?Q?y1c9EKpTfA+LgZXANTmWLkuXfu9B+Fu0RHdP6YmXbaOIpjaNeyGVpKH7/qxU?=
 =?us-ascii?Q?KCNA95SGiPJEyjdE4BLVKG8Tpn8MtFvVwWEvQeVOesPbodJjMyZYQym1dfX9?=
 =?us-ascii?Q?+BlReI5eQcBe7WNl1Wbwf2BmJ9hikNd7r8Fhpxmve1NyMZMsLHlIANmr7LdL?=
 =?us-ascii?Q?gA5UhUbzAv7hM0CEhNg54omaGE1itF79+AjqVl8eAUQMGWFl90ys8qhZy8LO?=
 =?us-ascii?Q?gEN/FgXmZ55BbrY5oIblpuptydrl7ZKZmvYmin44N+fvHVpPS4PsNErKcJg4?=
 =?us-ascii?Q?K0cIm8gB2Uzx95QXDPLZWvQDExlt05A0Xg7yYE1T50GVB0VYwWnp7946jGLc?=
 =?us-ascii?Q?NO8HoZfzsr5uJ9SIHscs73R83djVNlJ6ebITXWAAEVG4RrZwAHOEn2QzWWjT?=
 =?us-ascii?Q?5UyJnaZ+kasPnO308LK7ELKe6hLSAAKs19ajHzb6oiWmG1QYykGtgUo2uRiq?=
 =?us-ascii?Q?+DF1HsQ4fSJ7m4GqKWWtxTPvhCMK6jmP2OMeMXdVQyiZfnsBr5JkImA7MvY3?=
 =?us-ascii?Q?SLofhyjk5RKcucSDSFNAaVXHoOnvYqOjtxBCRHYajTUSMfo+DJLyQOu1XLA1?=
 =?us-ascii?Q?Y9hRXgvOyftY8xgYWcvhW3fUBWldPofYvcYk12G/6C/JzqBMZ45J6okoUqQf?=
 =?us-ascii?Q?9dmgRltJNCJoWVdpWPt27cjg04dxPbIa/Izsu2SEPkmiBwRRT96a6emKhyuO?=
 =?us-ascii?Q?CHI8d0YCydv75r4Ir4PB6d5hWTXHdnrEKU7PJYts+0hBBflpTGu0tQvkRegQ?=
 =?us-ascii?Q?us3MSgXruhLM589EgMS2geTCAtfiZ205NKs2QuxeOhF7ab7GE+FlJP0L5MUm?=
 =?us-ascii?Q?UYYq4ixdvi8pTOOx8UVgaOX01bdEUsFMsjQhOru8Gwyge+C8IZXAGONPms7E?=
 =?us-ascii?Q?xRrZ/oFDu/v9ATa+tkzhPjyrVVJYZqzpq0m82KZ7iinQS6nPudlNWItjiFv5?=
 =?us-ascii?Q?fR8BNM43PS1OwfGTULozYlaLYWFF1BkDfTHektYwJQkELe4mc6zpN03zJF9V?=
 =?us-ascii?Q?puX1eSUDQo5O7AxnFNCHXetJrhY4j0UM9JjBifmJ9ostBfn/EcDEhiPrKiUr?=
 =?us-ascii?Q?/92YDpINur+Y7QnERgfd8HjKJWtRHuP09SAlL5a1X7lMb0qYvmWbNG6bYvQ7?=
 =?us-ascii?Q?OcbqOposfEf6/vN2mMo9Skj0afXso/o/RwtmcDYxLbZM17lPtWkC6yVg6fKD?=
 =?us-ascii?Q?XPIR/3veMFMVEOW1NzS7ipxuKe70URcoGJ36/WuCAfLHX/59nwy3LNj1OVQU?=
 =?us-ascii?Q?SBsDllE8mAzFmoKR/H4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0cb175-33fe-4bd6-b443-08dca9f453cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 02:16:42.2551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2pdDRu8JKfcfuWPpCUebfXEGfDGszpbGaEHK3OpZVkeZUU1lEaJHR7BeoT7bPPuV/dO9vt4zEC72bPrCm3fUsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
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

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Chai, Thomas <YiPeng.Chai@amd.com>
Sent: Monday, July 22, 2024 09:48
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.co=
m>; Yang, Stanley <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com=
>
Subject: [PATCH] drm/amdgpu: fix ras UE error injection failure issue

The ras command shared memory is allocated from VRAM and the response statu=
s of the command buffer will not be zero due to gpu being in fatal error st=
ate after ras UE error injection.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index e97a5e0ce208..d6aeb53563ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1630,9 +1630,7 @@ static int psp_ras_send_cmd(struct psp_context *psp,

        switch (cmd) {
        case TA_RAS_COMMAND__TRIGGER_ERROR:
-               if (ret || psp->cmd_buf_mem->resp.status)
-                       ret =3D -EINVAL;
-               else if (out)
+               if (!ret && out)
                        memcpy(out, &ras_cmd->ras_status, sizeof(ras_cmd->r=
as_status));
                break;
        case TA_RAS_COMMAND__QUERY_ADDRESS:
--
2.34.1


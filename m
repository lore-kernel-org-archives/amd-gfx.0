Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A94EC87FD2
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 14:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D667B10E1E8;
	Fri,  8 Aug 2025 14:22:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sZy6HM6J";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D93110E1E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 14:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xub87cES6cKuWpLkwqmLCMrxWSDk6PZIQ+Hwewjbu42gaGZ1q7cndoyL6mnKAEYB66eQu1YpsGB9wkutcnCPsJscz8u5AgtG1HBp4BZ4hpUDNkxNnNB2ixiHJPhjN4E8ksibSJ38Ed2a4J8/1xGczH9fUxzsR/GZA+I3OvUyry8yGXij3p+yhKWOWByTa/D43dMVDAjHjnnnNMeQyG2CQ+gqbGtnP307hs4DbjqgMx2xhIfiZPICZK1Z28CQElTCCays1ooFSmlEb2dicbyufieH+W5ExVCwSIs4dHZ2eH5tJfSOJuz4Co6ywqbcO1JS+5A+wBDvZ9tlzw0WGkKONA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qz9/iIqKzVAnjsQTXnrY3NP3SbEC9T3stkOFftiDYs=;
 b=y9tuHTrod3FbLiefNWxD4Syas+NVYLDcQ49mEooRky7mCkB/nstL8iJLq4ytnbYp+kdQwfMg6fGUSSzqfHrI1lvblmeaqKYENawSVoQB+E6CEqxvtVO2Ofn31Gm0W6zpdyBSMXPRJwjK0AIZd9QDNJgPtne3GOHqrWVIX5zzesISOoTR+oJCdiEQsjIehbxCEAhgaXKehitBBvXsGjMXTsDop9+04SNl9+faGi3it5yplxRkyY0Jd1yfAQDCVxeNco3AzZ1Tmqv0E5dAszR5rNeWC6T9cv7BJyhw+rET0IxujbF12Yf0qmQFDPEs5dQBpgVYg2HnKvu+jL8CHbFzxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qz9/iIqKzVAnjsQTXnrY3NP3SbEC9T3stkOFftiDYs=;
 b=sZy6HM6J7Ih9v7b+tgJXBA/rqFb9G9Gsmj6rRgEspMxGMc5qAxlDV9BQuWwzn/K5P6bzvDx3kinx+8uqR2NMORFCHAxD7LcQ6yEBHcf7g5hHFxrRI6DtDUfm204uZH1vh273r2hXybgPkfhS5asXjZ4UxSdoLeIkYpbZPNyZDrY=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH1PPFA0A5C3BCA.namprd12.prod.outlook.com (2603:10b6:61f:fc00::61f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Fri, 8 Aug
 2025 14:22:53 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 14:22:52 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wentland, Harry" <Harry.Wentland@amd.com>,
 =?iso-8859-1?Q?Timur_Krist=F3f?= <timur.kristof@gmail.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 13/20] drm/amd/display: Add analog link detection
Thread-Topic: [PATCH 13/20] drm/amd/display: Add analog link detection
Thread-Index: AQHb++qoKp1hRMc6AEanvzf1Hyq+h7RXpoYAgAAW6oCAABA5gIABFM+AgAACnGA=
Date: Fri, 8 Aug 2025 14:22:52 +0000
Message-ID: <DS0PR12MB653418F9D051FFB2E37C18B09C2FA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
 <20250723155813.9101-14-timur.kristof@gmail.com>
 <fd4adcc9-44bd-4f54-b37c-3eb4dc286b03@amd.com>
 <e68d8be2-4687-4a51-a2ac-1ecc73cef355@amd.com>
 <24b4249761d7edb8df8551350475fd6dce274d93.camel@gmail.com>
 <b06f9e54-c99e-4c4c-b310-ad043daa50ec@amd.com>
In-Reply-To: <b06f9e54-c99e-4c4c-b310-ad043daa50ec@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-08T14:12:21.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH1PPFA0A5C3BCA:EE_
x-ms-office365-filtering-correlation-id: d84f5628-aaff-4972-7bcf-08ddd6870fb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?e6AynW2Usduq0wQuyOY1WpRck4NDXNVHQFj74XId8anJ6hDj73PzKqSw0T?=
 =?iso-8859-1?Q?tuzCt71vn4CqV2yBE7djVoQd0BO1uXBJGgxOZqIv6PUArch7D0QaEHW/c7?=
 =?iso-8859-1?Q?pPrbGAftryDNP9DgA9wtoDf17zoMiZHH1gDOQV65OFeTD0yzdCloGunbBY?=
 =?iso-8859-1?Q?92G8QbYw8n65LS+YG5D23nEgImZo1QRAJu0553Q/PejMY0FOevEeNSA9//?=
 =?iso-8859-1?Q?0Zd7LxxNAc4X69lRvWZy+nmav+Jt7gTk33YnlUd1IxmpWtKCbVpDRgUkAb?=
 =?iso-8859-1?Q?TQnjL86mliyzpsmmjMuCOtWiS9958M6phN0gIyU3yqi2g0pOLIDsbxb496?=
 =?iso-8859-1?Q?Hs/wNGtKXeTsjugUwDTsyVN+uCtKrYFUeCkX1WkZVcHeVGd5lIlDnZPaR+?=
 =?iso-8859-1?Q?HoBtDyJsmZl16bJx0wqS0vn9l+5MaWwEIMI4wbGX8GQxV1/ETSsZZTzs4d?=
 =?iso-8859-1?Q?SjUV+lV8Al3N0ZJ4viG9NevHJO0L0a3BrTITYDEbpU2z1MiWr4qX0e2Jaz?=
 =?iso-8859-1?Q?3RtkS63XppCcKus2QaPGXjMptpx6TGPsQxu3blYbpCGK0OYtspxzseMgnA?=
 =?iso-8859-1?Q?+CNjp6eR5tLDCgJl01T+ef5xmyk5euEoQC2bSDWSfJ2dHptORfknaPxRNQ?=
 =?iso-8859-1?Q?wxSFvuIn8jz1sBnUDB3GBJOeCgLrrLENCziMqFaMt8oRgxGvJBoIz+6wUD?=
 =?iso-8859-1?Q?0OKjt4162XVsWR/7WfPuc4hoxXAGu+s32P1b6ZI+4w16i7RL9sTXu5FExB?=
 =?iso-8859-1?Q?oi4ZSrO9oJnUpWFTQiAeF8+lGseNGnE+hYXVZb1dqsffR2S6a6TXakyauQ?=
 =?iso-8859-1?Q?DSgilNPFlDSr3rfDcFTv7KDNLnD0k7/i/NonTzbHYr/koIctWQkRUPGoIJ?=
 =?iso-8859-1?Q?1mQQgurRvtZ2i2pMsugwKR6uvX1jAuyZbCT3N8fQV1ZqO8GOflrPZc5qtH?=
 =?iso-8859-1?Q?GMoGB+8Bn6LW8LilXyZtA7R9/BXMIYZ6aCBrJdITsbONvfr7u4sh5pL5GE?=
 =?iso-8859-1?Q?39O4fVZcgOy8sQJudbrS/4b9ODyePkAoZbFFVTXo8iMXVOM6BkJWaNE+ha?=
 =?iso-8859-1?Q?zq38oFiwXF3Z+W6D7eRnqwFCg14JZIY0GlduVEyQtuZ+DprjmbeuV6y55p?=
 =?iso-8859-1?Q?Tn/zRt1jco6hr+Pc3UwOhK7CPIXCvFwSd2giQnZPp8pFGiBLlCzQK1GT6C?=
 =?iso-8859-1?Q?XX2Lm02iTrGBzqxqGgnMbkaD8dVTBU7pFn3BKDfrgNM+egrv3UbAqt9bPu?=
 =?iso-8859-1?Q?Wurc2KrwWvEeZvfRTXbOm7XGlu9/E9iSAN6WGLQAOSTSEkB6EEaQvrH9aq?=
 =?iso-8859-1?Q?SefyOj9UvUH2CQQxw3QKLKCO4jFGJisYlaPliqak/QNiC1J+iLtSsW2kVx?=
 =?iso-8859-1?Q?nt71+b0jyKt3JE2MJ3qh7Eu1CDZDDTHs/ThkVpw27kqKqOonZH8J+ZCdA5?=
 =?iso-8859-1?Q?I1eiqYuTAVa/7ygUdgXvfypSS8HtqMDwWbZiRZcb5xyG2zHBzSiXOF82Ss?=
 =?iso-8859-1?Q?E8xawodtle/QCYpV0S9kdFUgQQfN7SYZnQFr5pvrVGYzNGS596Ygfr8Ln6?=
 =?iso-8859-1?Q?EsLuOYs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2z9XkvLOw+VaRByrKOYmRyOy1auMpcYbJWDfntzYY73iqJ1mlUND3rnQOQ?=
 =?iso-8859-1?Q?Q8iCXzTZOlb0GNhiT6UTx+9R3kNqs4u0eqk0aG4edmmnfY3PzVgmsFiqi1?=
 =?iso-8859-1?Q?UpUeynj4QQedaLSxofOuc0h8LX5jvVycvvoTaRP/wjP3/exhYPsqnB1zAX?=
 =?iso-8859-1?Q?/z1V9jFA4Q2Oxe7L3PZMw0AtR6L19WFC1cZXLxzHgEZMnpkPmCHWbZelir?=
 =?iso-8859-1?Q?/cKh6qKQkeJ0sFdKtJEp11IBCt7DNtP38XZHspEyM4jGuxpm3fU1uWDCKz?=
 =?iso-8859-1?Q?MDeJzdH25tJ3WyueYjcoTpsdeALZb4iMhhIxRdo7rgyYFoHx7Sp8bldew/?=
 =?iso-8859-1?Q?g7Gflrdi7o711piy8LQBLZ+lvTgAYDMq63zZkX/RLy3NdTo9axtKhmUAF5?=
 =?iso-8859-1?Q?Ehyv58ggl8xnO5+zhOgR3S24QAGAmF1q1XCCLZi8nfcMZIcIgUhdFtS0zL?=
 =?iso-8859-1?Q?5G3ksvMOcjm2VowgQvx4mB4ZH2MFwjohWGUC7U3E9BAcuLn1nLvUwVLDIi?=
 =?iso-8859-1?Q?lK/MMedz1PU7J8A4rdJoZ6d5JwQ42ZpRALY4Gf8vQOEJyrKUjMJKOoG8Ju?=
 =?iso-8859-1?Q?aP4CoN1eytYl6hFrntkFKO6Qa59DPNe1y01Z9h9Q/WHbSFa2ncmZqWU9ap?=
 =?iso-8859-1?Q?ClJUEv6DZl/OS6Lv+AgUGAyz6h2vKZDUJf9NMySbbkdDEDFJTeK/OnlFuM?=
 =?iso-8859-1?Q?pVwTPT/FyIZreHwzSUN4ZcMXV1PDnbTUlZlPWIth8ti1Vr5vXD9FE0NbZc?=
 =?iso-8859-1?Q?wCdufAvOeAeRi7EEBYTEe2ieGALRRQgDRsVH/DOVCwMpKkdAmtrlcAWAeI?=
 =?iso-8859-1?Q?ncmYpVxiZ1vCA0g2C2OhdzhZDCONWnHscAA7NF+vVoLQ2IDGMwg1jqLfwD?=
 =?iso-8859-1?Q?X8ctsLIjlnFytEAnzYLipH1zomh8RNJUMSX1YLwLd/IDs9dbsghcIC7X+n?=
 =?iso-8859-1?Q?EsUDvIdMVh/kV1VOdFCwfqGnHvWN8DI6eJr5d6+fD1Og3Z7uNcYUgqGTVR?=
 =?iso-8859-1?Q?R6KNz+zTsoN2SY+f88AeViTC6os/FP/nw8lFfH8m4yAmkRZxXrrthqbRI9?=
 =?iso-8859-1?Q?AACCbRlLfI9YIHmziL8B5MwRzMOM+HHFJ61fu7H1tUeVWakGIJIEqG0HUb?=
 =?iso-8859-1?Q?3qYzeX+3i8S6prDGxWPTqnOjr5xVGVpquFjO2eEfwHigSV94lIB43RXoqs?=
 =?iso-8859-1?Q?UXJsMjB9e6dw3rqTU1PqfpjSzmG5n145IjzVENUx6ZxGxosIk5mh36/kqi?=
 =?iso-8859-1?Q?UTlCEvRHgVzxGt6ObrZh0fAX6Vsl6u21dGYlgCwcdBilluta2sd/B750t4?=
 =?iso-8859-1?Q?ycqlCbYWBIaLS4Lh6cy4m7IqGlFLI7Mj1Vat3aU91lDSgCZy+wK6ofgjRo?=
 =?iso-8859-1?Q?vXuDaIa/U8Nh0ewnl3uOSWEDmkyHe847iORslRkuL90Hw48UDN06CHyPCb?=
 =?iso-8859-1?Q?uXgl2dVkUqZ9h5+3PSE3e4Rc2lDSYIrNdfFMeB+FMbThGwI2cZtnistE4i?=
 =?iso-8859-1?Q?VnVXqrdeRzWk6eSXhAM8Wq74WblSNfrGU5+QfhNIUuaVTNKr9Id08p2zJW?=
 =?iso-8859-1?Q?hf3aaKu6Hy00tzmV30HayWWEHlCTx72PHqcaannO7jZDFpOAOraQfSUtIE?=
 =?iso-8859-1?Q?gOdUYRFegyHHM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84f5628-aaff-4972-7bcf-08ddd6870fb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2025 14:22:52.8572 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EnwBOramBCluR19Ly2nSzfshc0oVS+WCNsTCIi4nvcqh42Gb5aEt6hN8Zi93WoT24hOUoOEUHTIowOs/kfl5gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFA0A5C3BCA
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

The NULL pointer happens right after this error -> "[   10.046542] amdgpu 0=
000:c4:00.0: amdgpu: [drm] *ERROR* KMS: Failed to detect connector" and onl=
y happens with this error. When bisecting the patchset I was getting just t=
he error without the NULL pointer, and after removing "drm/amd/display: Add=
 analog link detection" there was no NULL pointer or error. Probably just n=
eed to solve that error and it'd be good to go.


It looks like it's an APU issue as I was able to reproduce this on a system=
 with an AMD Radeon 8060S and eDP or DP, and yes, the NULL pointer happens =
at driver load.

Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Wentland, Harry <Harry.Wentland@amd.com>
Sent: Friday, August 8, 2025 10:03 AM
To: Timur Krist=F3f <timur.kristof@gmail.com>; amd-gfx@lists.freedesktop.or=
g; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: Re: [PATCH 13/20] drm/amd/display: Add analog link detection



On 2025-08-07 17:32, Timur Krist=F3f wrote:
> On Thu, 2025-08-07 at 16:34 -0400, Harry Wentland wrote:
>>
>>
>> On 2025-08-07 15:12, Harry Wentland wrote:
>>> On 2025-07-23 11:58, Timur Krist=F3f wrote:
>>>> Analog displays typically have a DDC connection which can be used
>>>> by the GPU to read EDID. This commit adds the capability to probe
>>>> analog displays using DDC, reading the EDID header and deciding
>>>> whether the analog link is connected based on the data that was
>>>> read.
>>>>
>>>> As a reference, I used the following functions:
>>>> amdgpu_connector_vga_detect
>>>> amdgpu_display_ddc_probe
>>>>
>>>> DAC load detection will be implemented in a separate commit.
>>>
>>> Another regression in our internal testing with this patch,
>>> unfortunately only on not-yet released HW.
>>>
>>
>> While this shows on unreleased HW I wouldn't be surprised if it
>> repros on other (recent-ish) APUs (integrated GPUs). It's just
>> that this week's test was on currently unreleased HW.
>>
>> Harry
>>
>>> I wonder if pipe-ctx->stream could be NULL in some cases.
>>>
>>> Harry
>>>
>
> Hi Harry,
>
> Can you elaborate when / how it is valid for pipe->ctx->stream to be
> NULL when the code gets here? Maybe that would give me a hint how to
> resolve it.
>

I don't know. It was just a guess.

I should've mentioned... the NULL pointer access happens on driver
load.

Dan might have more info.

Harry

> Thanks,
> Timur
>
>
>>>>
>>>> Signed-off-by: Timur Krist=F3f <timur.kristof@gmail.com>
>>>> ---
>>>>  .../amd/display/dc/link/hwss/link_hwss_dio.c  | 16 ++--
>>>>  .../drm/amd/display/dc/link/link_detection.c  | 80
>>>> ++++++++++++++++++-
>>>>  .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +
>>>>  .../drm/amd/display/dc/link/link_factory.c    |  3 +
>>>>  4 files changed, 95 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git
>>>> a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>>>> b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>>>> index f3470716734d..b9ebb992dc98 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_dio.c
>>>> @@ -58,8 +58,9 @@ void setup_dio_stream_encoder(struct pipe_ctx
>>>> *pipe_ctx)
>>>>            return;
>>>>    }
>>>>
>>>> -  link_enc->funcs->connect_dig_be_to_fe(link_enc,
>>>> -                  pipe_ctx->stream_res.stream_enc->id,
>>>> true);
>>>> +  if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
>>>> +          link_enc->funcs->connect_dig_be_to_fe(link_enc,
>>>> +                          pipe_ctx->stream_res.stream_enc-
>>>>> id, true);
>>>>    if (dc_is_dp_signal(pipe_ctx->stream->signal))
>>>>            pipe_ctx->stream->ctx->dc->link_srv-
>>>>> dp_trace_source_sequence(pipe_ctx->stream->link,
>>>>                            DPCD_SOURCE_SEQ_AFTER_CONNECT_DI
>>>> G_FE_BE);
>>>> @@ -98,10 +99,13 @@ void reset_dio_stream_encoder(struct pipe_ctx
>>>> *pipe_ctx)
>>>>    if (stream_enc->funcs->enable_stream)
>>>>            stream_enc->funcs->enable_stream(stream_enc,
>>>>                            pipe_ctx->stream->signal,
>>>> false);
>>>> -  link_enc->funcs->connect_dig_be_to_fe(
>>>> -                  link_enc,
>>>> -                  pipe_ctx->stream_res.stream_enc->id,
>>>> -                  false);
>>>> +
>>>> +  if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
>>>> +          link_enc->funcs->connect_dig_be_to_fe(
>>>> +                          link_enc,
>>>> +                          pipe_ctx->stream_res.stream_enc-
>>>>> id,
>>>> +                          false);
>>>> +
>>>>    if (dc_is_dp_signal(pipe_ctx->stream->signal))
>>>>            pipe_ctx->stream->ctx->dc->link_srv-
>>>>> dp_trace_source_sequence(
>>>>                            pipe_ctx->stream->link,
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> index 827b630daf49..fcabc83464af 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
>>>> @@ -942,6 +942,12 @@ static bool
>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>                    break;
>>>>            }
>>>>
>>>> +          case SIGNAL_TYPE_RGB: {
>>>> +                  sink_caps.transaction_type =3D
>>>> DDC_TRANSACTION_TYPE_I2C;
>>>> +                  sink_caps.signal =3D SIGNAL_TYPE_RGB;
>>>> +                  break;
>>>> +          }
>>>> +
>>>>            case SIGNAL_TYPE_LVDS: {
>>>>                    sink_caps.transaction_type =3D
>>>> DDC_TRANSACTION_TYPE_I2C;
>>>>                    sink_caps.signal =3D SIGNAL_TYPE_LVDS;
>>>> @@ -1133,9 +1139,17 @@ static bool
>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>                            sink =3D prev_sink;
>>>>                            prev_sink =3D NULL;
>>>>                    }
>>>> -                  query_hdcp_capability(sink->sink_signal,
>>>> link);
>>>> +
>>>> +                  if (!sink->edid_caps.analog)
>>>> +                          query_hdcp_capability(sink-
>>>>> sink_signal, link);
>>>>            }
>>>>
>>>> +          /* DVI-I connector connected to analog display.
>>>> */
>>>> +          if ((link->link_enc->connector.id =3D=3D
>>>> CONNECTOR_ID_DUAL_LINK_DVII ||
>>>> +               link->link_enc->connector.id =3D=3D
>>>> CONNECTOR_ID_SINGLE_LINK_DVII) &&
>>>> +                  sink->edid_caps.analog)
>>>> +                  sink->sink_signal =3D SIGNAL_TYPE_RGB;
>>>> +
>>>>            /* HDMI-DVI Dongle */
>>>>            if (sink->sink_signal =3D=3D SIGNAL_TYPE_HDMI_TYPE_A
>>>> &&
>>>>                !sink->edid_caps.edid_hdmi)
>>>> @@ -1228,6 +1242,64 @@ static bool
>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>    return true;
>>>>  }
>>>>
>>>> +/**
>>>> + * Evaluates whether an EDID header is acceptable,
>>>> + * for the purpose of determining a connection with a display.
>>>> + */
>>>> +static bool link_detect_evaluate_edid_header(uint8_t
>>>> edid_header[8])
>>>> +{
>>>> +  int edid_header_score =3D 0;
>>>> +  int i;
>>>> +
>>>> +  for (i =3D 0; i < 8; ++i)
>>>> +          edid_header_score +=3D edid_header[i] =3D=3D ((i =3D=3D 0
>>>> || i =3D=3D 7) ? 0x00 : 0xff);
>>>> +
>>>> +  return edid_header_score >=3D 6;
>>>> +}
>>>> +
>>>> +/**
>>>> + * Tries to detect a connected display by probing the DDC
>>>> + * and reading the EDID header.
>>>> + * The probing is considered successful if we receive a
>>>> + * reply from the DDC over I2C and the EDID header matches.
>>>> + */
>>>> +static bool link_detect_ddc_probe(struct dc_link *link)
>>>> +{
>>>> +  if (!link->ddc)
>>>> +          return false;
>>>> +
>>>> +  uint8_t edid_header[8] =3D {0};
>>>> +  bool ddc_probed =3D i2c_read(link->ddc, 0x50, edid_header,
>>>> sizeof(edid_header));
>>>> +
>>>> +  if (!ddc_probed)
>>>> +          return false;
>>>> +
>>>> +  if (!link_detect_evaluate_edid_header(edid_header))
>>>> +          return false;
>>>> +
>>>> +  return true;
>>>> +}
>>>> +
>>>> +/**
>>>> + * Determines if there is an analog sink connected.
>>>> + */
>>>> +static bool link_detect_analog(struct dc_link *link, enum
>>>> dc_connection_type *type)
>>>> +{
>>>> +  /* Don't care about connectors that don't support an
>>>> analog signal. */
>>>> +  if (link->link_enc->connector.id !=3D CONNECTOR_ID_VGA &&
>>>> +          link->link_enc->connector.id !=3D
>>>> CONNECTOR_ID_SINGLE_LINK_DVII &&
>>>> +          link->link_enc->connector.id !=3D
>>>> CONNECTOR_ID_DUAL_LINK_DVII)
>>>> +          return false;
>>>> +
>>>> +  if (link_detect_ddc_probe(link)) {
>>>> +          *type =3D dc_connection_single;
>>>> +          return true;
>>>> +  }
>>>> +
>>>> +  *type =3D dc_connection_none;
>>>> +  return true;
>>>> +}
>>>> +
>>>>  /*
>>>>   * link_detect_connection_type() - Determine if there is a sink
>>>> connected
>>>>   *
>>>> @@ -1238,6 +1310,7 @@ static bool
>>>> detect_link_and_local_sink(struct dc_link *link,
>>>>  bool link_detect_connection_type(struct dc_link *link, enum
>>>> dc_connection_type *type)
>>>>  {
>>>>    uint32_t is_hpd_high =3D 0;
>>>> +  bool supports_hpd =3D link->irq_source_hpd !=3D
>>>> DC_IRQ_SOURCE_INVALID;
>>>>
>>>>    if (link->connector_signal =3D=3D SIGNAL_TYPE_LVDS) {
>>>>            *type =3D dc_connection_single;
>>>> @@ -1261,6 +1334,8 @@ bool link_detect_connection_type(struct
>>>> dc_link *link, enum dc_connection_type *
>>>>            return true;
>>>>    }
>>>>
>>>> +  if (!supports_hpd)
>>>> +          return link_detect_analog(link, type);
>>>>
>>>>    if (!query_hpd_status(link, &is_hpd_high))
>>>>            goto hpd_gpio_failure;
>>>> @@ -1269,6 +1344,9 @@ bool link_detect_connection_type(struct
>>>> dc_link *link, enum dc_connection_type *
>>>>            *type =3D dc_connection_single;
>>>>            /* TODO: need to do the actual detection */
>>>>    } else {
>>>> +          if (link_detect_analog(link, type))
>>>> +                  return true;
>>>> +
>>>>            *type =3D dc_connection_none;
>>>>            if (link->connector_signal =3D=3D SIGNAL_TYPE_EDP) {
>>>>                    /* eDP is not connected, power down it
>>>> */
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>>>> b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>>>> index d6b7347c6c11..ac25d89a4148 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
>>>> @@ -2256,6 +2256,9 @@ static enum dc_status enable_link(
>>>>            enable_link_lvds(pipe_ctx);
>>>>            status =3D DC_OK;
>>>>            break;
>>>> +  case SIGNAL_TYPE_RGB:
>>>> +          status =3D DC_OK;
>>>> +          break;
>>>>    case SIGNAL_TYPE_VIRTUAL:
>>>>            status =3D enable_link_virtual(pipe_ctx);
>>>>            break;
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>>>> b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>>>> index 71c10a1261b9..c9725fd316f6 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
>>>> @@ -555,6 +555,9 @@ static bool construct_phy(struct dc_link
>>>> *link,
>>>>    case CONNECTOR_ID_DUAL_LINK_DVII:
>>>>            link->connector_signal =3D
>>>> SIGNAL_TYPE_DVI_DUAL_LINK;
>>>>            break;
>>>> +  case CONNECTOR_ID_VGA:
>>>> +          link->connector_signal =3D SIGNAL_TYPE_RGB;
>>>> +          break;
>>>>    case CONNECTOR_ID_DISPLAY_PORT:
>>>>    case CONNECTOR_ID_MXM:
>>>>    case CONNECTOR_ID_USBC:
>>>


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7620D1BDC7
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Dec 2025 18:12:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833BC10E054;
	Wed,  3 Dec 2025 18:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AObqKWpE";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012043.outbound.protection.outlook.com [52.101.53.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4207B10E054
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Dec 2025 18:12:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wbu+MaFwR1+MiXUtGyOMjb4FyAG75JloxCnI+bUKXAnY/fo/tFlrO1B9MlRpMvleSTGkd24jD3866LpRfLAir/HZKTCVZfMBrxzdkFMGTAa9fBbL5FAkBqqq19jYu6BHhpU1VkgjYMMq7ds2SMLEUdQQsggWQFy81coJ+CecoPgp6GwWijcDwaNVwApCgDlDC26qF8Scs0wVY5rfDRkN6BCbrVmAdpekPhQoUe90tWZfvhnZeb+oIbqn2kJpog9Qped37di9fMzvBcOx2jSQ04YfHrXhfipVUUvqOynmlzOgE7z5IUSE6UK86YPT9krrAa/X0/m0NGra6zCtZkncrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTIJKWNrZtcbpIkiDunOTlsSoFcIDKi+zd8jefrEhxA=;
 b=iqsZXd1DFqrGg4EL+wbF1S/bP3meo4o/b+2eOOmCUs4B5c1XDlPqf2HLVNkM3D0nQOQFbP16ExhAKzZKkFP8CbL/J/Nx6cOwzNbMHCbeB+KvknTV24IbJmiLyTKFqXcbYwhmE2xztZR8yysKWMoMU4DGW6kOktz7SPmhvTHh5bgDxBJ6z0T4qTjWPh/9FZliWRCYS6RHVoW81Qdw6SavZiTkM0x/LMOxE22LZdNUfd5GYSBbrf9dm2bisYP6YEfizIK0BC3kP1CLiTn9by1DPCRz59KN4o0TPN/ZCoo9/f0hr+NOEZbLrofijYSZFF6d5DIa/aLEcT/itloPf4+oQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTIJKWNrZtcbpIkiDunOTlsSoFcIDKi+zd8jefrEhxA=;
 b=AObqKWpEVrBCYSyE5C0VhURwG46d2RKY132C/MSY8b30GatGBwzKtsKnOpeUnXcFqwAk9l4V/8rpKhR3LrHBtjue0CuEYM1dMinBCxqoH09gVIsYIAPaANRDzYx7yo6Y0tYxP7J0dpRLBE9PtDI+aWGSJCqXAJ9suowwrDC72AU=
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 18:12:27 +0000
Received: from SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993]) by SJ0PR12MB8138.namprd12.prod.outlook.com
 ([fe80::633:3c3f:3a9b:993%4]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 18:12:27 +0000
From: "Martin, Andrew" <Andrew.Martin@amd.com>
To: "Russell, Kent" <Kent.Russell@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v5] drm/amdgpu: Ignored various return code
Thread-Topic: [PATCH v5] drm/amdgpu: Ignored various return code
Thread-Index: AQHcZGNjpu4mNYHpFEKWQeRQ2SjAmLUQLa+AgAAITFA=
Date: Wed, 3 Dec 2025 18:12:27 +0000
Message-ID: <SJ0PR12MB81380A3BC561CE1EBC297AD1F5D9A@SJ0PR12MB8138.namprd12.prod.outlook.com>
References: <20251203144435.62300-1-andrew.martin@amd.com>
 <BL1PR12MB589874A177F717DC7956CAF285D9A@BL1PR12MB5898.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB589874A177F717DC7956CAF285D9A@BL1PR12MB5898.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-12-03T17:34:59.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB8138:EE_|SN7PR12MB8103:EE_
x-ms-office365-filtering-correlation-id: bf36d920-0142-420e-f3ce-08de3297843a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?eC3hiN1fkVCZ67EH3K0G3/7OsP4ya0uiapd4WU0n+inHyFfbryayNGxNoCmT?=
 =?us-ascii?Q?zTwayE5PbpJ4iSGJT7s2B4JyOz1nXNk4FlS4NNYB0DjbdheWcUhhnOpz0Qac?=
 =?us-ascii?Q?QmtkRSJzDOmI8guZlXkp60sO8Z+NmDPI1VJrGWmDld8tWaqfIhAbUQsDMVkP?=
 =?us-ascii?Q?pufZfMTAOf6OEBOG0OCAwIZHc+FeZrqw4WJuwnFSCW/lkE9PTCsMfAtBtWx/?=
 =?us-ascii?Q?zXqEttuvz4LiJrDL9/yVZkJi27hrMVrSzdI41zSYpSvEWEkm0pGQodwIpxT6?=
 =?us-ascii?Q?4pLQe+fA+pNDo8pGYfIBClb5GrVkr7hlQX5ksm62+pMVVODWrAqZF6gPmsEA?=
 =?us-ascii?Q?dC91tU2ylIk/ZMI3sUwAWS74Y8UA+c9pG+8eyTwDvFa+Nt08PHXbJQ+cqOdL?=
 =?us-ascii?Q?yl++W87lKQJ5nNcg/yrouUW7YDx2FuJoDGg/hKroAhsgJqE2xscIl1RkOeCx?=
 =?us-ascii?Q?Myq7eGUfICl6FfksEfBQ5+UUfAXsqOWyuvQgBAZj4taCAndkBaXlgQCQI9lY?=
 =?us-ascii?Q?qxRqeZBn+Odf2xEr+DViU7iwVVnQOXrYtB3BooTA6bzelQ2bRXuAa0a7McLW?=
 =?us-ascii?Q?MdETDxOVpMRktfr1FmJwFqX0d2botfR0FW9Xtg/RmQJ1gOp0qGKDy8zS2WL/?=
 =?us-ascii?Q?7GEl1DMmPafA5ODISoXA67E35l8TR3ahqJg8CIFeSB7EoJFNzNMtoJDMP3ak?=
 =?us-ascii?Q?Wj2o+N+RNjauJmk4vM5qSPlVxUFMs6VRDPWCGxknmxtA8loMbFJBRiN7UfbT?=
 =?us-ascii?Q?XHMa8cOZn9JRI2oXK1f25R1/bLv/y/p69pDRKTkpWwMHwbKNdGVIUIGU924m?=
 =?us-ascii?Q?JtEsBXA/uTI98JlZKaBh2+X4EPCV7XalGpI7LVrF58WVKujUP6VrxQCrN02i?=
 =?us-ascii?Q?0r1EqcrxgQxuCu0WKvxyOcGs1wGY4zpnHUqIVbWoAQgV7SPfMe8ENHwW7OkZ?=
 =?us-ascii?Q?IMxEv0hUhMwcbzPIJH7QEQoTK1spxBSQLxF5lmGLYvrdy18y8Mh4cqdsBw6r?=
 =?us-ascii?Q?bsQN/amYgQMxnfEpRPYaGyKmR3eg+1jMB2L4xrHwKx7SN4nTV4uQmGltRsBU?=
 =?us-ascii?Q?sZw4ZxmAF2VMThDr3rsbAKOd/Um3ibHjEvYwdBurjRvlczrdkHGb5wxXHXPt?=
 =?us-ascii?Q?k/jVUZgSwSEELGTSGsH+9isoZE3awTT0AME9MXrBM3LQbVclTwo2xgBKF/G1?=
 =?us-ascii?Q?1rUbD4XeRmBsWyxLWgSnaNLw+Vin6za2Yh2TX8mvAtfhGD5CopLrvTAbOZ82?=
 =?us-ascii?Q?MDj784WrB3FgUReZAoni/uSbOoPfGlRfa+inXZRPKCAaETmF6QKbAT8rgr4x?=
 =?us-ascii?Q?0AOghEpvPSQmkIttLdvFMThYWtEebAGsAMq8W/cTRtl+iF74UNSE4hnxafsz?=
 =?us-ascii?Q?QIj8dgyyFgBGbYdKm8y954eRTZDypKk7xK9cp5WJiEqyjdCZqwTGVT9RwKCX?=
 =?us-ascii?Q?RT87vYnin26JLCBeQS7peik+k/YKU0BROoZb0iXhY54YQfSD+pGLziiV8NAT?=
 =?us-ascii?Q?VuLNS0XNiHBrArRPwcdL0GrjFXzkr3kkH75r?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB8138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vIwf7vHKKDqliA1DVKjAyuJ1jZqTexs50LEc9Oxm3rhbdNr11pm501R6BFrs?=
 =?us-ascii?Q?1YLbPRAWQ00BM9wKeaEz9r8K1te2PmaFHMR7B5HZaiDQtsFrgoqrk3riJr9N?=
 =?us-ascii?Q?0q0SXPi29aBiY+mC8C8yx0WCJDWXiHlbFzemCizZPj8R2eLDpxfMVQq/6CJK?=
 =?us-ascii?Q?T4sf/PJEml6zqU2DMEzp2ibCxS6JszobLwyAbQIEjshdRP7KPhG0OU4/O30z?=
 =?us-ascii?Q?WSa3KDPaIuO9xZDqtfLEOlTx7zA8GOUbPp96XAdLLyFFXiBVwEmlLFSVDlVu?=
 =?us-ascii?Q?DoV92gHmZLI/7KxIoSibBb8Ctk4AsAO3In3I6K5be+HkLNjhb6isXIIuU+ws?=
 =?us-ascii?Q?Xm0SfVyCYto/VzbNln3WuewKgusGhp4ddgvSx/27eE3IlooMbnWLXP5unrgt?=
 =?us-ascii?Q?3IAKKgdujDe8X5KoAdreP+2Ocd1AMwp1dToy5pzrGkxjwuriivL6iEWwQhRf?=
 =?us-ascii?Q?6UqNa6yzQW9OCWPuLi0fq0FlrYzMuu10hJ0bv7rWykFF/oV+h50Rvdd4JgcM?=
 =?us-ascii?Q?mL/fbxrjWbcn4MYM8/Makj3GFkQHRTwVdCH+zI+GcbTwdMSgeyG/D+7dhU6E?=
 =?us-ascii?Q?ukmxIij7zpkcDL5qGHCRcpfcsQIK2t/AQSPfVrreH3hd+pN78Gojxw2jy3/d?=
 =?us-ascii?Q?e9qMfqhJBbyy8eEQ0++RP0RZi++1A/moOLxgnLxvAZsUIid3F9qhWqtdODKq?=
 =?us-ascii?Q?R4ezhKkst1IP0yqQ4akekYddmU8Kp4Nsl6rpdGe2R4o4xWBJFcqzl9OaLP9h?=
 =?us-ascii?Q?Wh4BMv8nW55lcOpPWexO+rkPhIuv6dLvOfLHKQPranXrrgpYMoQ8ooyqxC29?=
 =?us-ascii?Q?1oDxNm0AhIeFb+/R0j6qP97UnPWrFh/bT6nMravSZQwU8t9XhTpsuHhQM+jF?=
 =?us-ascii?Q?xu0LmsRCSi6UoNxdv2UyUo1WdGEbR/Xt0OAkztocPJ4WJcrVhs1kCYgyPjiB?=
 =?us-ascii?Q?/8paK4zl54ImKfOPNY3L9nSrOZQvdPb3bdqUJN26UiQVZOwiLV4Q+N6cWW6W?=
 =?us-ascii?Q?0+UqY/e6eoUKi/OV3xCylJOCu9r50ulJo4NQCJ2hOC371kpO35WbW+c8T9FY?=
 =?us-ascii?Q?B6opHd22s/ew3zwmyyhm2ZcBPzwCVDTqSOoF+S4uN9I0JBSTa/Zk1z6LrfU5?=
 =?us-ascii?Q?OEmHWnYHVrzKDRNcrJiBIsY0kACVSLssTO3OD9eeRjYXB0wdCdpnx7jWHaWa?=
 =?us-ascii?Q?D8kFN1agapq4Skj6gHUsHvhX066kHhWbLlFU1iawrki0Z+m52iUJvZNsWdYh?=
 =?us-ascii?Q?FnqLb7lq8gmIigT96yDwa2HjR+IaRX5vzW6FRYs8n0iDvWE1sdllXvk4M1HA?=
 =?us-ascii?Q?cWncHcuiwuIvdItLDErFhbduNAaf3EL7upQkACjdgvX78gXVeFJKFkdwjb6g?=
 =?us-ascii?Q?AY9UekZNVjfudOJ7rY/wxpdIoTgY+rg3tfoKZDiDDrLMw67I808iV4uwoHf9?=
 =?us-ascii?Q?xLgWcSBvMqtH96cO8FT9p87+nibi8HME7urS8Vw3DI9q5RueAHJ+B3so4Ftj?=
 =?us-ascii?Q?KmLYNEuRUytwJsbfCJsPmK3VXSzYnYKmVhA12ourIrlbGs8l3OGvrIFBl5ih?=
 =?us-ascii?Q?p9IW/vz4b7q21qkbJLQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB8138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf36d920-0142-420e-f3ce-08de3297843a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2025 18:12:27.2847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rgt22G8ickn3y1EaqsZCGOaGhWoeQMRu6Rdimy4Vb4bmX9XlIEF17qk9XSNGU7TyDRBVhi7P2fnVsWvKURJ0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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

Greetings Kent

> Can we try to keep it to <80 characters?
>
>  Kent

Yes I do try but, sometimes this collide with concept of keeping to the exi=
ting code style (though not in this case).  Besides the *checkpatch.pl* has=
 extended the *max_line_length* to 100.  And indeed running it: * ./scripts=
/checkpatch.pl -g HEAD* did not warn or erred.


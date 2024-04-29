Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BD0C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 02:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D287611270E;
	Mon, 29 Apr 2024 02:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j6V21Cno";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE5711270E
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 02:46:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgeN7oIcdVwe5hOBz586CBSXbLiqx8m7YtriwHLA3oyNk4gGZMgnt3IVY9H0BZIHXBnGKteAq1R80q2lprCvbvAo/37BW6IF78Eq8R0ActZ8WtHKx60NyrP735CxVWDh99CXwQ5M6FcIwhGbgY/mlNjyvDWzcKvROYNDbjPZwPnYQELWvwxIYp+tPKTluH+6lIhO3m0jsmtoIFGB1h+V2nvrqYd1kR+cfzpv9w3CeWvfwcvud/voqlSoaYuobAEYTNSVoSSkJ/B4VzjdBwehHjrNbf5jI6egHssSNMuAmpCeaVEsKFA8PA/kzoAlmWbELWZXEaGsnqP+u0qRRANTSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNcrqIwgYed1BTbZzoDSUXI8LxusTc30fntHuwuB/s8=;
 b=SOZeoCz9pPkfPJ5r4U6h8/DExgsXOu4EUz4FrdYt5y+y+SIR5SHVtAMcBkx/DY8cJRFxtmhopm7P6j+5aaFlYGNA3VBcFjGki+KitxSB/Z3KjsKep6GV9S2WYXvIXjk3ixBQyhwdWKp0eoUtaSwxsHqdl1sQ0xTMjazF+ntCFJHOLGjg987x4T5pebYFKXvNg+eOoEBEoXWPrp/jxqn2+woL3LZpnqncVfv+HV/ECalyLajhhtnOief2EB3ltWLtq1yqVQDUEttvDK2pdIJTltLP9Toa6FedZ53BXtnZD0QTPNqd1tKAwgK30qIE9M1ubKoFwVakwr77sa736/I5og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNcrqIwgYed1BTbZzoDSUXI8LxusTc30fntHuwuB/s8=;
 b=j6V21CnoiTuLTbI5B1eXf0kHAZcB9QqjNGmxAWjvfaqjJe5W/sc74ZSznRPF2GgWQpZnHATdSUcJPmo2Oo5R+6XMYOOzp5Yf+HIll9uD+lvkjYhuOcBTumsUHHIoxVFEfZlt/V2xDMn0d7MOOZ7lCkqCGg5oV9SO77/01JuW8zA=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 02:46:11 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 02:46:11 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Recall: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Index: AQHamd9lLnQl69l4a0ira16+/mQAXw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 29 Apr 2024 02:46:11 +0000
Message-ID: <PH7PR12MB5997406178946D10A20B496A821B2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ0PR12MB8114:EE_
x-ms-office365-filtering-correlation-id: 7540e61d-258c-497a-905d-08dc67f687ce
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?fct5XJr2WUxRxe/fHcRYd+eHW3CSSlHu+9CxRTtZkiThPGGVYT54aFzHzDE3?=
 =?us-ascii?Q?GC7f+t+rej4OxFmdidAjggYud0v+NcBhpNLea5fs2S6cwE7tUqtEFEwq8sjh?=
 =?us-ascii?Q?/QS/qi8EyRW3Ddd7TUMy37H1HKExMXYPnfBy2P6mvb8B5gqzOSBpIFIAe+0q?=
 =?us-ascii?Q?YhRQZzej9Ygb8AvlvS2CaEWiVf+AZCw8+bHIgmkyf4fb5ySgjlOVpikWRO8v?=
 =?us-ascii?Q?6wN81/5k/WDB93ZMeIkkp3wA22k/mua6wEnla3zLVmSCg2ySJBo/+LvXfUhN?=
 =?us-ascii?Q?Ihe2QXYCeI29qaKcHs34I99pIKynzJOZ9Hee+tzamj3vUUd+hjKSW3BXvlgM?=
 =?us-ascii?Q?SfOMzrJFI8J8ogDwDGDPDdlLJOHgZpdTBMfHCNClUZshXsgmD7hjnHF/cCCF?=
 =?us-ascii?Q?/zr6bbvcEDuM0nb8TOK3/F2rhO1hwq938gjPwHp0g66m4hUIo5laWXlVRTAh?=
 =?us-ascii?Q?L5pVON/xfLaJCphLQsLmLXYSpBxFGYxIcSsAROzg3fCfdOPIOfn0PYdZcFjU?=
 =?us-ascii?Q?JpygHgTtDygTnuKIyXoKRFZzCL2arlbyvvnfNJ2QGypWIHEH0cG6bkri/lG7?=
 =?us-ascii?Q?Ivsn01Wil/s9jQNjKdGkpvDNFjXLkaHzFLlpJPlv8G51a/4wTdIBQezbFMjy?=
 =?us-ascii?Q?pw93bYBVCNL7Y/EBZQNbM7CvpPNnGQac2qRoCd4CxL3dRDIy7DKmmliBOnp2?=
 =?us-ascii?Q?7UNW/bwUgc0g8gYflD4WX3sK9AM7wXa7ENT/XqvsujQkW/IudBg1OeHooewW?=
 =?us-ascii?Q?jrcK85uqBiPnvVh1DJUrMQ/t86adlUFjs26ZrW5rtv1moT4ajRQuZrdgjbp3?=
 =?us-ascii?Q?BUOm3HI3UG3RDy2h/lu+8eKax4KEKs43HrpGJkO4kPdjNOWwwbvmu8PFqRhs?=
 =?us-ascii?Q?kuTc2NRJI0xOzaZHmYTM7iochIttJ74XS2k86bg5DWGxzMlIe/uBPuLHNnxO?=
 =?us-ascii?Q?A340g3BSG3YJhhleChS0T5639FKxGhk8MwMblP3ZRZcB/wOpE9MaKPqsd9lQ?=
 =?us-ascii?Q?WGkmMfcztlFYMftrqourzb+cwEde1Z9kALXbUBfcjkH4Ubx9/v/RVfVmRVSO?=
 =?us-ascii?Q?+0iiRLCshw0wgm9OaIjrcUlyvZoEOssvGVw1w3zw9CjX0Kdzt5Q9zyiU7OUR?=
 =?us-ascii?Q?HPhPtIiM7jxCO8habrdwKDqBRTD9khtaH1fD2TLcUYs6XP4DYvhjp3rmTMKy?=
 =?us-ascii?Q?BjlsEyb75s5CFO//mw/CDYoW8+obSViBvQSvt1O5Aj4olfZm/1GNUHfeQFDQ?=
 =?us-ascii?Q?wli2Z/Cof3c3h9m97+ymXHQsSGceGeBpNNg1NJFae7BnokZGwQL8tckWlMt6?=
 =?us-ascii?Q?CGTULIeNbI3nokFgD6567zUaxVUeFSwfZARNvGZh+GEHSA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GbruqKPcyMWfdlqRaRdzWF5Ey+MTmX9LOsRgTm1+hLh5zXny50co7LRAhyny?=
 =?us-ascii?Q?LoTysTKWOaNlMwNN7anCNy9IHiw/+NASol26xFv4z+8Q6VOdV3CQtUv22ris?=
 =?us-ascii?Q?SIJkEnCPPfbMZDQrFm5Di6TEvJG6iplX1jcxn0PIBICL182L8i+uwVjAy6oq?=
 =?us-ascii?Q?A+a/rJwca2jPti22kJ9LwzCv1zniAazLLkNfP/pzgh6tZwv7YqtUhEKy9VbP?=
 =?us-ascii?Q?xw1gqZS8N55BiLrD9nbZIISOqeD3WYMdqh/ZTjXkQ9nqAaxj8Wa/mmaG/ylJ?=
 =?us-ascii?Q?Tvg4Hf50Kg6TNjOwsd+OpQVD7PkHZCPU7+C1z2qJJVn6Dk/PhlrsTCYRw5Uh?=
 =?us-ascii?Q?tdvVj5aOVtZwbNQzaBWgm8yvDkSH7Tg83dnnLP/QMmmCJgDxqREfdyQxMAFz?=
 =?us-ascii?Q?WUl4jrLzPZY56SVe4VkgUubifnTsbAe4QukxI1mltoJcef2RlEEBDvFUCvlc?=
 =?us-ascii?Q?cmeuu7HsbMPx2HkpSV0sHPWlWpEA2SfRN1QOMRzaI3pHl5wzr9v070ZH0Ejf?=
 =?us-ascii?Q?l8pFGzKVlBK/On1vhqSncoToLvN/qkW/HWwZkxC9iJ1BnuTu5vaqzU1JhMy4?=
 =?us-ascii?Q?iemWLYwtPDNs7RtKYCGa8rbycM+7fmkowh7Oje1qLmct7USMPprbrY5YzrzS?=
 =?us-ascii?Q?U9XaoxDT5moeHnGH/hxMDSHREW3fzoGdm3iolopyqIcS8QmodRZo3l3XBFUv?=
 =?us-ascii?Q?xAsDn+gu4RkTjqn2Tq8w75MhElAY0x/Bc9uJqtyiWRvAEsthnJYG3ZG82X5d?=
 =?us-ascii?Q?U96IpAq5yaveqvRdPVcJ9h0+Ox2BGvEcPisJe8dziF97XgTVBB4FPDTokgSS?=
 =?us-ascii?Q?IL0KvW84qctP041qkPELb58wM21nQGHKTBAIvscWi317quCV1fOk8XF+yvPj?=
 =?us-ascii?Q?AVHAmECwHjjseobRFVVxkEr/0NGsheBvAYzDVYuhgdX0Ob/afH/oJXyJX3vc?=
 =?us-ascii?Q?h9rzmwRBlVZYOpI5G01ccppGNsbdz1vlL7XYpyJSsTwEHsY7/tMleQrMc2eo?=
 =?us-ascii?Q?mQGRMr/OeZqMMNrKdCm/shkW08I9+m696ndj8x6J3LfG5s6TVWtxor2arqKV?=
 =?us-ascii?Q?KEaXWdiZjPoESEt9ghKgkJfUCdCXNO1DtH81wyab4mqCuD3phqOqZzucD5IJ?=
 =?us-ascii?Q?3wRI61djR7FJ+SAoSqkAlV1xBsjv2vYxCy8mYItJEkhOkM0l5mSwMmyifjl1?=
 =?us-ascii?Q?fpVj1wSO2W1CYDAGFXEdDcPXh1HZh47w+qrmJ3FJcAv9/zYCEqxMATU1LdoQ?=
 =?us-ascii?Q?kO2eIHQGKsOKx4e7ZmFvh4kiyzFiPPBuHKv2yVHF8jBE/kZCgZ4YS4xA2GjL?=
 =?us-ascii?Q?za6dddgp2NbhiJJKZshVBsMstx1sCeB0J5K+gnciAcMnTpbQ/Ofghk7E5qlJ?=
 =?us-ascii?Q?Grnw/B6D/YFDBdQ9XFA9OCTpwEZttKgJ7D/7N/h5GRNmwKFCFDhajlXXDOD+?=
 =?us-ascii?Q?cswT2GO7eZXcQPCcekxcxOHv7GD+qlUK5t884cXGCjbpOOe4xRx4xb2g9ZIc?=
 =?us-ascii?Q?ssPAvhTkt1CSKXQAKYUxwS407wu44ZVP9mt3hXODJTypSZhOZYV0x09acPCm?=
 =?us-ascii?Q?DPGjW9Mp7UZn99NgzdY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7540e61d-258c-497a-905d-08dc67f687ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 02:46:11.7322 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S287j/ls4Lzb4mDRg8/dd72rNuYWiQ1zhcSDxAu47wfehuzjkJHjJOnXk5EGeOUn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8114
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

Wang, Yang(Kevin) would like to recall the message, "[PATCH 2/2] drm/amdgpu=
/pm: Fix uninitialized variable warning".=

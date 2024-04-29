Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0918C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Apr 2024 02:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E821B112707;
	Mon, 29 Apr 2024 02:45:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jf7sq8+T";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C1F112702
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Apr 2024 02:45:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMdW7QAYa5YAK+OR0pYLsOAmKZxiWvWreLRJxC1JkB+Hn5QcMjxSWZXffhxyfax+OKc7gIEesAuIDuKR4poB3TCy5CxFabXEURMBwePUaHSlg5bYPueaSDFJRadUouF6ALsDpxoN8xMQA8VcovA+3blD6kIBx+CKDeFnIJKL7epiYubf19TUksuJhLUDJkZQoYUGyxwIvulXtHAwdIIWgIEqF0gdsKGfpF618w8iFCJGgZjsUMDl9PwRkcyXLSLutVFL0RqUVyy68Zf8xcwwyIREN7Indiy3W6fS5y+0Bpb+XYm95vCO/MoWEFAfz6S96NtilIjJEnf7JBx6jYs9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNcrqIwgYed1BTbZzoDSUXI8LxusTc30fntHuwuB/s8=;
 b=l6BxQ8eAwPZzPWr7gw81IBi4Oe5y/XPsKfUlJ13X4ty7BJD45UL7i6h+pzOUHLB3pgVBqs/7w8sN8jyCgnpJvTI94uz8RKw1emMS8+aD1jPcB5JhsQjslY+YMmuLTZ1CtLhtMiW89y3e9gA2CDL4DE8mkevdg/74x5BXIsiq3gcGicPN5ZUUoHIuJhXBNm29LniWVEnRrW68ZMaD3L1b53s9dw/whAI5lPKrmshxl5jxxEBdX5HbiNURsHnZxemvf64L6k/C14LAx+Gtttg/6O+QX+7PN1lUHS01FKUYxaus2ZH7ENdDaikCw7reQk1hMWbkOFbE1RTuyTvB96Vnbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNcrqIwgYed1BTbZzoDSUXI8LxusTc30fntHuwuB/s8=;
 b=jf7sq8+TpNVntruPgPx29zCn8EFGUUO8wSBcu7fek0KlMg+dtu4ND8aKrlg5M0TvrQYvYtA+WMgD0V3N2EwtiAefO2IZmq4PJr+udJx94CahZiSi1oUYD6YLBei2QdDB8suohHyLdSLJb2SpYtoNgzN7CRxVwAWo0z5Y6/iMFzs=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by SJ0PR12MB8114.namprd12.prod.outlook.com (2603:10b6:a03:4e8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 02:45:45 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::d1a1:5993:ef75:9419%6]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 02:45:44 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Ma, Jun" <Jun.Ma2@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Recall: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Topic: [PATCH 2/2] drm/amdgpu/pm: Fix uninitialized variable warning
Thread-Index: AQHamd9Voil3uwBQg0+buvjUFxQxyw==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 1
X-FaxNumberOfPages: 0
Date: Mon, 29 Apr 2024 02:45:44 +0000
Message-ID: <PH7PR12MB5997B6FAAC45D2E395970E55821B2@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|SJ0PR12MB8114:EE_
x-ms-office365-filtering-correlation-id: 228589dd-08ee-4c3d-c183-08dc67f677aa
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?YvD2BvdYe0WQTph3joL5/SxNvD+XA4YOd8HMnIwmfdK3mjIqZY34Tfbd9JBv?=
 =?us-ascii?Q?jHYhCOIO2uYWpQ3np0qLpfZWgu9LNLxcFC9EjWYwGl81f5wuoiiMi2lhpWhy?=
 =?us-ascii?Q?C6iO6MWLC3LuzM1nILXymzfCFU/HHdmFdU9sepHJ7zZ4JA27rdqc8BVp/Go/?=
 =?us-ascii?Q?UkxsIFQCKZtjc/PqqsgP8POJtsvbA1k8xSEm4xG2GBnrxMwA2Ql/EEA6b0GR?=
 =?us-ascii?Q?0TSXpb79OJ3S/Cl6EE8kSNcO+DwVaZnly66ChQSTVk49eeumOF29XGzJNBbg?=
 =?us-ascii?Q?c+Glb4NMFoQKzrGtkRJjpoqXDT6EdeYJcpoKnwju2kHBzKogX0H3Mt9sMKJG?=
 =?us-ascii?Q?bvrzROU1T0R/eYiNW1DPxeRu6BTijXL2xJfzXPnC2i0+eTGxSq1bSRkL/dDN?=
 =?us-ascii?Q?DFq/BvbMWPCZkfRPOEW/BBvEhG/grTmJ+eGpvzPG4GTWDasykfKbH/9d7dXC?=
 =?us-ascii?Q?sT1UuTlhuUZRx+hCzYq+ovuRDL0J8a3K+sfNkMN3x6qFDmiqHj4L7YQ5c52P?=
 =?us-ascii?Q?vGX6EuHz85UrR59CBy+70SaFMaaTh/YFnGm2bCaOJtm89mzIlLPr39Xh+F0d?=
 =?us-ascii?Q?b/wtcXaFPDI9excv5XGdW3RahwOJNn1lUvASVMB6AEuskCJ3N7kVm84OWs9j?=
 =?us-ascii?Q?1jvcmap08NlHBgtX5apapU+cambozaxd8JiIrlP1EW0OOQSvheLBnbyDj/wb?=
 =?us-ascii?Q?2mZvMANvnsd2zsv3U9lXkfLaw66GKQ45rX70X1ARBsSUmWUstK+VI5S9Ya+7?=
 =?us-ascii?Q?AYkCEyzz1zhwwmGAnObr9T9uZHtqHcxQqfI1aoUHVgoVchiwe5wSgjSzTwX/?=
 =?us-ascii?Q?0IvVhjqiWgXwFA+JwAkCNP1MrwUOXgGZh55w8f5O9XwQ+PI2i8qOxK0Kk/vf?=
 =?us-ascii?Q?6uCrXpvozFUM9jGNb8Cn7jjooTEenQ1Qa8zNZQmnnSKvYmyPn15ATpXdvDsq?=
 =?us-ascii?Q?Kayb129lSDr9ZBr4oRL2HqauAZ0v9a8shyfj8mJHzD4J5PrNsEmaGqLX5a8n?=
 =?us-ascii?Q?QOqTnyLCLHNGcna5Kzs3TUnuxHqTVgbtaV+WsOu7coOOZeuPFclrilNc/NL3?=
 =?us-ascii?Q?RfQZkPlyws26N2iOnaZx4ngHj2KYK/mViy2y24wTIfwMqI8KMgx18cGUpT/S?=
 =?us-ascii?Q?PbkKeW4qM0BtWgPPqWVMAetb7Vpo5f9pLcOAdPNSb9FsWDOrACLXU5v7OZPo?=
 =?us-ascii?Q?F5x9cgCYRmynWdYJRgmGt3gbK4/XUzc6ygR2MuLEsEHLaD0ElMPtD76WWO1V?=
 =?us-ascii?Q?R1PpdHOlE1X0aLmUWlWBibqaThootIehKYZZKd8pZlWGUHuk0qXpUoCkz9DB?=
 =?us-ascii?Q?aQXqbf0CKIi/JkJL9uggNZ9kGmtn5DN7BAh1TqUBUfjW9w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVB/deeXchI5h/TQIeBHcL2YtEOHaw/tZ+Qj8NXB7mMg069NaxhRxZUxVGUy?=
 =?us-ascii?Q?Wpfs/JlYTF8O/x/qTmr3Fy/XkL24+4+USewzju0hK4zJNx6HweNal1XQunhV?=
 =?us-ascii?Q?2G3UDrJKO7UZbuuqIbmalbTu3PGHJwuvJBXIhzFArJfgla3K36ZYpQg2eCfR?=
 =?us-ascii?Q?8vKYKNoirnvz8qOk9tvQrXnsLgBmk8VEsiQvYTTCjIDI5iU0YbHL50sAkQHC?=
 =?us-ascii?Q?vEztEPOvQai0xZBFn2R/Nwi2DeRMgWY1cNTOKwXYArVRdlyltt8xZ9V+RPnv?=
 =?us-ascii?Q?/MdSkP0IExvoeDVwq8BkEBa3vgpTIm3/PJ7xrr7TnAn8vAVQrJHzG3kjwAPz?=
 =?us-ascii?Q?qKOq2/7VFSngfae/dvE4SaZFdiJy9uiELaBHOv4Ntp6R6XQVsEsESHmC7Ehf?=
 =?us-ascii?Q?HZ9IMjH+SgyJazTZ5/IwNudBIoZk9IgV6QLx21V1BkA94We761Ae/+lBHVYm?=
 =?us-ascii?Q?a+FgllWzn60USBh+LMoKavOts0uVEQPkschK89Mn9+cAfWL9j+Mfi2c0vIxX?=
 =?us-ascii?Q?eTReA7A75AzCvoN9cwVgf5Je+DbOgnCrP9Ncif8bc0lu+QdA53fbFpHqidJ9?=
 =?us-ascii?Q?dG/A7FHLiLI0DW5+O7mvlhnI4caNYYNjriXspTaFMiVTMa4pzd/APSaRi6tG?=
 =?us-ascii?Q?H8OGAFDDmG0/n1DweL0KIEH00Rbmme9llgJpuFN21CBzUnnbgM/4aF5BgItW?=
 =?us-ascii?Q?o97too48Xw3PCz9tjx6libX04+Utd5sMDssV+2atVUhIXHmDzAYcTWxuaO6E?=
 =?us-ascii?Q?56L+rQzLJsBJEdkaCH7DHFKN9uR/ERLE3miLLl+p9gYZ9DCLr+LCEFemnXb2?=
 =?us-ascii?Q?fotYHpj9TXcG9IxsaDLGZgiwO0rWvCNqsdWDA3N62EziJ+8vf9P0h05XsOFy?=
 =?us-ascii?Q?+Hu2AnMWt8ntWO8exuzlr6pdgHWQcg8LLBJHSEiVnSSx1NyWtkKDvt/rWHjs?=
 =?us-ascii?Q?EeQBrzy7sjultuqc4P7j+TsH9tYXJ2ByhYnmWJbNyDtIVUE9eKaSaNBgbEoI?=
 =?us-ascii?Q?YdLjkf+yHadOtU2Rq7wf9RZ5AkHtRiPVh08U0ak2U550cZ7kQMC0aiXnsf5v?=
 =?us-ascii?Q?peoJK1NI2PFnRBqvNG1udxe34fEito8MVqPBRI8hAxGgOO4I24GMoLEolnXI?=
 =?us-ascii?Q?nsyHW2k/rz5z7N/WdH9RmMWXIy7pj/6ifsO3RHW6IeS4b7p98tR9ghg8+vrU?=
 =?us-ascii?Q?3BFLpfSFjecchZUXTWDwHZS6FmQoUTAvX3ofjMzjkj/K8KkywlMGLW3FVXWq?=
 =?us-ascii?Q?Xr1Pv8cU3JnyDVmtIdE8FAeIOjW7zvof6hxSyAzs2yZibxw3yJydQdIVqaxa?=
 =?us-ascii?Q?ldHP+lw8vBQSV+0JFQCXx7TYTEEDwDe4zSiRnDC+hdkYBAQNpnVbCg5jY4ik?=
 =?us-ascii?Q?IqQjSCUdHokWzlpYX7nz3FsMNgPZMSgCdVfVE47Gp6dccdTVY5ATHFn7TwTi?=
 =?us-ascii?Q?gPlD3Vu1AgEP+lgCOMW19wzCeCTLZIE1UDOxiXMBP/GHAd0wUfrK0ns2K3f2?=
 =?us-ascii?Q?eSth5yUWDoJgZhJ1Cq6j6g8f2ECAousqKAOuoITsmeaj+l4/XAqrBANfiBN9?=
 =?us-ascii?Q?+7VI5PbIVYMvQzSMzhQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228589dd-08ee-4c3d-c183-08dc67f677aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 02:45:44.6584 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HbCMmQ9p8cb+QT1dfIaquIYL8b6Lpf+ocRiJ40+8UNTKLKZOeijXrJmV/V0lz3zj
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

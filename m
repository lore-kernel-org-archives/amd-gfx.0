Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE1DD216A3
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 13:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB68A10E0BB;
	Tue, 15 Oct 2024 13:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ALWLm5SC";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8AA510E0BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 13:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EepTWiWAbbQRVpW30/6/Xtd5X1CZWmsNfnkEmTuMrinYkH2t2wnoraDG5d9zKEuq2EmN5m0IEn4Myr0m9LFFUwgZk7sHr2zfbEOlgtTc/CRRPRNDP48lAU/bzwZjF713iQtmQ0tfn6Hsis/KBDwwsXiOnrwECtsB4pim2wL6QCeQ1MEiB6xramecQgFwmFb06lx6WVeCrQWE5lk9vQ8iL5lOp/PHtVbFQM9VDgcj4ffjDunr5d8mDKaYv/VkTxpXupuvrTOTAFoeWwuExpXQvcUv7VNFmVZqQ4jC3Wimz5dDgP1XBl6K1ZtSEny45jc14aBOFJjSqWnYedoUV/pTRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxNHjrHzNYYQW0HHRPrgez8JEOJSrYcekyDUekJYvio=;
 b=YattxrDDdMQveN8yBbQlLDkRvpsMBAvg1Tjrv2yUg5EK/nZZL8Efef7XNbd66/5TXy4CbEzj66pWx8blmWjFnoiug7lZQZHurlZJg8kla2Lwuv6KLZkBqvOUlohY85NxXg2MScRHOtVfXqMy1d/HRd2FCjrY1UPXn1udiIG8BrjMTuRVcCztaMWoTqhfMpNVVekRK5lgbchCJKrZ+GYKEEnvZogXMSVeCj0+15Oyu335Hjj3h7d3gcAm4axkulYqJkfMmv8+8hAMVqw4MxueLPjpcHH7nqWs8cewi0LQR5T1kiFXBI4C1OFpSJjLB7w2olXrNNjjQtKOf+//ocjCQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxNHjrHzNYYQW0HHRPrgez8JEOJSrYcekyDUekJYvio=;
 b=ALWLm5SCknYVxCOcGfqnxzsdqnzP1aIMLuIHVxQL4mMYdZhSwnPoQv3wgxkPZA6xOsABFcUJObEeWBJKFSa1vb+LyehjAaYG52mcJ+r3gMx9LGwGnaEWgJHtbpJdhmih9A3a7dP8VGtNNAKmh4sUjCOmw5AQMo/8R040jGrUk4E=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.27; Tue, 15 Oct 2024 13:48:54 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 13:48:54 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Chiu, Solomon" <Solomon.Chiu@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/16] DC Patches October 9, 2024
Thread-Topic: [PATCH 00/16] DC Patches October 9, 2024
Thread-Index: AQHbGoENwtjKlgNArEWWrq+rO3BQsLKH3I1A
Date: Tue, 15 Oct 2024 13:48:54 +0000
Message-ID: <DS0PR12MB65344F6F01B3852BA54489EB9C452@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20241009192344.650118-1-Roman.Li@amd.com>
In-Reply-To: <20241009192344.650118-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=1529e30f-6837-4961-bb19-b77d97c2fb2e;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-15T13:47:48Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS7PR12MB5910:EE_
x-ms-office365-filtering-correlation-id: 9b57fdbf-bef6-4f71-1aca-08dced201c18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?ioiZE+xDADFG2RRbpQzRKXfQCiFsB3uryNkf6ZrmQ0Cyp9P9Lf0Tq9ROXm?=
 =?iso-8859-1?Q?Xb6J9JGYk+rWIKYcb2XVt7lORoXnvmW68XvbSK8r+mvV7uHgJ5wqO9kfyt?=
 =?iso-8859-1?Q?vqNTyiZuYy32keoati3zwokzpg+5RRHMb5mQMT4FWDxYR4tP7YIkY3ynVu?=
 =?iso-8859-1?Q?/jxoAM280gB+jU1YBB+kfjoGwlB/EDfDMBDcosG7XcdZrSGCmzUuRpPrDC?=
 =?iso-8859-1?Q?uWIsvOyFCw9yW7fwSJR7Kn4m6zdZGjCFY2GoIrLw29lYlMC5somzGSu32p?=
 =?iso-8859-1?Q?BVWLmHgRupP8heb6GhlrinGT+mZhxb1xLO6d1NklCCXe+4Kg5lm3btjePL?=
 =?iso-8859-1?Q?BvpB5kRgRkqDcE9tsK+kiJZzfAgicWPnQbqG5G0AKChxBzelOdcO8b+RwJ?=
 =?iso-8859-1?Q?wqjHNEqEkHFZuKBCfJRNXnGmEmr7G4QDDhxAYjOKMXrtUe7BWnmZmJBEZ2?=
 =?iso-8859-1?Q?vPwxxN8prlUPUhkc9Gh9c8iFSaDqHAlDqxYjItzHLchj+imIE4K83R+v3I?=
 =?iso-8859-1?Q?yVRZxWPOzLSkXEDmxsTO7P76vFyrIB1GiU866VoIiN6MU60tjo13MxU+zG?=
 =?iso-8859-1?Q?sqtlJodyo7fphfxlhQ+6oXaHmfvZ+EWEfl6qro3Jw/sVZnlcmCjPW6pXrf?=
 =?iso-8859-1?Q?W5RWFtrKH0H8LVqJ0fTjrhhasy3tABoxyS4FvzDhzhCDEId751JyVhTAdr?=
 =?iso-8859-1?Q?a+eVIIGZeK9GCRiz1yzcj0oOxibpU0SzPSfByrqpWhJQTeWWgUxnlfBzGk?=
 =?iso-8859-1?Q?0UfbJZ+tkghN4xIiGbUGjSsd9Kka2GJWnIncvjZVpP+jrPqOuDwtbQxICX?=
 =?iso-8859-1?Q?Asysqi1+UBHg+y4bHvZYMl3zxjexGddf46ragFu0Fp2V/GyvGcSL6lBQkV?=
 =?iso-8859-1?Q?hSEJ+LbX+cKvvCktE9cGIGrePjJjxJauoUNB13ShIdPMJosQ2BRvfP1D/t?=
 =?iso-8859-1?Q?FdhUyYh9Fkq9rCngjQX3MeOGbAqxgapGA4KVsEGLP8MNWLJ8JxQWgvUvzb?=
 =?iso-8859-1?Q?C4oVkO/KAt+Jov59GzoUSq3EcJ4t7uhdXdbpduilUipUzNr3Mn766SovLS?=
 =?iso-8859-1?Q?Gu6D7rkUBSh+/5hNsFQz4F2gte8286eyVCcIe3unwt++AUhNIUd7f8I6Ln?=
 =?iso-8859-1?Q?vBrabEepfYw1FKuZFqkEzXb7dtomtwwkQ429ezlRGfYQBsSRjfiSCTBcYb?=
 =?iso-8859-1?Q?oun0z6rNL2pI2ZIRhJk9Ok1G55+XYnm2MaEDwcuP3J+IpPfpnsxrAxNkAZ?=
 =?iso-8859-1?Q?k6G/VX+Tt147kHjx34KWR+68gIJaM41cxTAsUbDfmqxsKhQ5gXb+ourkXi?=
 =?iso-8859-1?Q?KRqC6iqWHQE9dlVTd5yrHTphHGJHS/LmCMb5eBeAScTAlhJvw0xBxPpDer?=
 =?iso-8859-1?Q?sf6hYKlNnAJyaq4S+R478bJNAm2drSnQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iGWPpoSH5k570RYF443eV/a7up38IFlVzshKKLBLb3GRLZkHrVMJzXQXA0?=
 =?iso-8859-1?Q?TkVtdOQksixicO1tH43TZbgSPIa3A0NCmEPUqOUl0CnowsPGvAcr3u5gEQ?=
 =?iso-8859-1?Q?NHFJd1r5Pa4UfphLuRuh+KToZsY7+jRa5EAEujUeXVfYhgVcl+yUtVmeu2?=
 =?iso-8859-1?Q?cM4U59iBcE0OqZJpEvpmUbFc3LO+AR0+uO0hseu1H5EjpsiO4O3KslFJnE?=
 =?iso-8859-1?Q?hoEXvJ99wg6zwF3BnYBHKFPUyJYPXNgTmY9EUgOUz0nty23wg8nDjcz+Qs?=
 =?iso-8859-1?Q?imaL7Kvi1zPi2O38xLECd707APABbdrplxnIRp4VCRKemEboSBcx3Rrwpl?=
 =?iso-8859-1?Q?9BsXy0JBjki39vI3o9q7JUWzBqcrFJu3pmRaC5NjEm6nRy+8l2KYWU+iR9?=
 =?iso-8859-1?Q?TJkG6SxFE5Zwb/+A5IBKESariPYrVDb55OFDajLqLMjaE6UWg/YWdWkbdU?=
 =?iso-8859-1?Q?AHTbDJsMm240ODNyL+/BShbnHF7YNNHdVlgyWtbkjm892y3Ir5J4JzubIh?=
 =?iso-8859-1?Q?1DvjLDU2yjxft8HFu/L+n9aF6s2H4ylc0pu/0reW6HK49GOCWnebDh8iyw?=
 =?iso-8859-1?Q?sATg9AJYt7/fhW9HkQW9EHIlZr+Jo8GIXKD5GrD4y9YTdDbAActoP4KLz/?=
 =?iso-8859-1?Q?vClhNkVSNeKKfxpf3sX50Mbfw0GxM2dzqVs3bqwjpJEgngcMdJmoioYpcx?=
 =?iso-8859-1?Q?z2z2MoxKCzb0l0Epm00uMDGVFdnFgjmn7GTnYj7XWBy0CPXnvVwMkmBphi?=
 =?iso-8859-1?Q?ESqLTFkmhPqlNUXWeqhMqT844j6VmpW652WfzM5TGhpXGiuIoWwJ8RlYzk?=
 =?iso-8859-1?Q?/rCh2UFM06p8OJ1BYsMJuwJjHqwF9ADVwQIHc4o2jQQxY0dwRewLooYLyS?=
 =?iso-8859-1?Q?QjTW4wZra5c+DpjuadYO1q9AFRCX2RYyIyZVrsOE5nIQ4M/IJdcN+lRUjs?=
 =?iso-8859-1?Q?5+renB/juqdkLG9pH/Ca0uGJnl8w4GSWMkwygLZ3pqrEZPNrS2sh9I6FEW?=
 =?iso-8859-1?Q?OrD6kovzT6vYrotEQ1rKwORsimk2Tz81TlnqVqc7aUNWKSSQ9yDmlXA6+5?=
 =?iso-8859-1?Q?hiPx9oMelK+O1KhUo/AT7OxettIKAeRzZrEeaQFqeMLWjFKZEPj7CNy1OW?=
 =?iso-8859-1?Q?HRPHO0sqn444vs69uX7I503JWvFN/zPLp2oREncmjLRM0VwurcOBlZYjpo?=
 =?iso-8859-1?Q?Qs4OjkdsDs1TZrSOJD1MZks/CRHQy9m9zPp8Kk/k36Ss1+wWtskYbWCOgS?=
 =?iso-8859-1?Q?35LXc1I0jz6wyPWsgI3hnMGgRIjSMhZWio3YZDHc3lAgWsseluYBYK0wrl?=
 =?iso-8859-1?Q?MQ62+YEVmNO2a2X7hz9jG38wJ82fjsRTR+VpnMatOe3crOpu2t7OF4Mfyq?=
 =?iso-8859-1?Q?FQFxCS6HwhToxgLYaReiBTaKuKb91/PCshx2zyK85vo+fnGE1InKKlAcaN?=
 =?iso-8859-1?Q?4C2RJykSfDA8ZeOVRzDv08cTYea0cgi+/CL4qjhJkuMNCQazSjgsFDrWR+?=
 =?iso-8859-1?Q?mCAdpd52aZs4gEhJzuUc+rU3bsVtXSFttyY5iBeLoW/skCKuMmXAUbFnBK?=
 =?iso-8859-1?Q?/Qgg4y0xumAo2x/StCaHTmakZkvNjrhSv1/BDeOu4+mZavbteC9YU0XCuY?=
 =?iso-8859-1?Q?e89urW+zhFiCA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b57fdbf-bef6-4f71-1aca-08dced201c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 13:48:54.5658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7Qa+qJWYzOAE+mdAdU7PZshU9uymPfPRgBmn5hXxTMsi5RPZBZHRC/wkykY3j840/Q8yRszFfnza08sAGThVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (HP Hook G4 and Lenovo Thunderbolt Dock, both with 1x 4k60 =
DP and 1x 4k60 HDMI displays)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 9e7=
8f8ea8dec8492aac6fa2411b8853ee2237bf1 -> drm/amd/amdgpu: Fix double unlock =
in amdgpu_mes_add_ring) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Wednesday, October 9, 2024 3:23 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (T=
om) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zae=
em <Zaeem.Mohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH 00/16] DC Patches October 9, 2024

From: Roman Li <Roman.Li@amd.com>

This DC v.3.2.305 patchset brings improvements in multiple areas. In summar=
y, we have:

- Add sharpening policy to plane state
- Clear pipe pointers on pipe reset
- Resolve correct MALL size for dcn401
- Read Sink emission rate capability
- IPX fixes
- Coverity fixes


Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (5):
  drm/amd/display: Check returns from drm_dp_dpcd_write
  drm/amd/display: Check status from dpcd_get_tunneling_device_data
  drm/amd/display: Remove useless assignments
  drm/amd/display: print messages when programming shaper/3dlut fails
  drm/amd/display: Check returned status from core_link_read_dpcd

Aric Cyr (1):
  drm/amd/display: 3.2.305

Dillon Varone (1):
  drm/amd/display: resolve correct MALL size for dcn401

Ilya Bakoulin (1):
  drm/amd/display: Add 3DLUT FL HW bug workaround

Joshua Aberback (1):
  drm/amd/display: Clear pipe pointers on pipe reset

Leo (Hanghong) Ma (1):
  drm/amd/display: Fix Coverity change for visual confirm

Leo Chen (1):
  drm/amd/display: Full exit out of IPS2 when all allow signals have
    been cleared

Robin Chen (1):
  drm/amd/display: Read Sink emission rate capability

Roman Li (2):
  drm/amd/display: Increase idle worker HPD detection time
  drm/amd/display: Add check for headless for idle optimization

Samson Tam (2):
  drm/amd/display: add sharpening policy to plane state
  drm/amd/display: disable dynamic ODM when sharpness is enabled

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 17 +++--
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 30 ++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  8 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  9 ++-  drivers/gpu/drm/am=
d/display/dc/dc_dp_types.h  |  3 +-  .../gpu/drm/amd/display/dc/dc_spl_tran=
slate.c |  2 +-  .../dc/dml2/dml21/dml21_translation_helper.c  |  1 +
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 -
 .../drm/amd/display/dc/gpio/gpio_service.c    |  1 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  1 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 20 ++---
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  8 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 13 ++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 73 ++++++++++++++++---  ..=
./amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 +  .../amd/display/dc/hwss=
/dcn401/dcn401_init.c  |  1 +
 .../display/dc/hwss/hw_sequencer_private.h    |  1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  2 +
 .../dc/link/protocols/link_dp_capability.c    | 16 ++++
 .../display/dc/link/protocols/link_dp_dpia.c  |  7 ++
 .../dc/link/protocols/link_dp_training.c      | 11 +++
 .../link_dp_training_fixed_vs_pe_retimer.c    |  1 -
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 31 ++++++++
 .../dc/resource/dcn32/dcn32_resource.c        |  4 +
 .../dc/resource/dcn401/dcn401_resource.c      | 28 ++++++-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   |  6 +-
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  3 +-
 .../gpu/drm/amd/display/include/dpcd_defs.h   | 19 ++---
 31 files changed, 254 insertions(+), 72 deletions(-)

--
2.34.1


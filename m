Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72168C71155
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 13:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E7710E3A6;
	Mon, 16 Jun 2025 13:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="izYgUkn4";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D99B10E3A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 13:16:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfkI3g5nEq6Ako1lfoIbNgS7Hm6uVw8d2fYlgeYDLLOQvwJRvI+6haBkYK+p2xIj5vte3Lugx3Froz2co+juE14AeRGCTKxCDRnyt0j+DwFngeyMOg+SYDxN3JKkMvMLfml9wWqa59u/iqq+2Gp0jVUxS4h558guYTxCbMtsUgN+GQAxVq8prYSweaPxwqLhI7htQ7ESqGy3OolfXBkFHHSPPMf8KdJR0ekW2xrr0LLzJyGYNjiUlY1RYGs2SzXtv7fgulFnNcwUMNQdjQ0xZ1Jf95QYIz0hyUHBw86Fkukdo8ZUC3QCHntUfFeAYfRC0n+t2RjBSqLmWbxMh4CWqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XmZ95RZDCypNtfqyHcT9SwFw6lyCTIEg7DXRU8w0mA=;
 b=JJc2eCbddZsT0FrJ+J/75/VtthrHI4v4CW1TolA3dfm4dzkHf0/efscO8CCTWDhChDhwNgctQxr32C4+pxly5q12xq9n+IQnyCd1iRmybYQIKH6h8J82xD/FNblnFEONAvIgcX8zHn+Bl6QqWPwIvuRv9i8yVr6DPjNY87JmObc92Xp2Uh9nglj45aBE2xjZNkGO6pM9uZ4JKizeEbH3KZNEWtCFxWZHO3Mc/A45vMj5ZGzbwGVBG1MkhTT7rG5fz+pMrcd5m6TrRCIW8A8KsEDBtwonJVWzUl6FvrrSQFFp7hNBwUzwnyNYRMhOkM4uBJs3aSwIB6YObNDA39udGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XmZ95RZDCypNtfqyHcT9SwFw6lyCTIEg7DXRU8w0mA=;
 b=izYgUkn4f32MSwNHxUppXmP0OKBFNxc1wIHsDwdHJgvWga7w7WbaCx1GcRSsZRnc/7cZ4ybHj3GzfBGRiH2W2H+rrkrKvV3NjUPFXtqZGi8yAfeJdJBP4LNGTj2YKKM7LNhVo09z0mn6hkooef4KjsR+WIzCaUqFAb0eGivPx5Y=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 16 Jun
 2025 13:16:15 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 13:16:15 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Hung, Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/10] DC Patches for 16 June 2025
Thread-Topic: [PATCH 00/10] DC Patches for 16 June 2025
Thread-Index: AQHb2wBoXEyzCmnFL0Stc16UY5CT6bQFyw0Q
Date: Mon, 16 Jun 2025 13:16:15 +0000
Message-ID: <DS0PR12MB653462CEB6312FF67E3449419C70A@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250611184111.517494-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250611184111.517494-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-06-16T13:16:09.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH7PR12MB6761:EE_
x-ms-office365-filtering-correlation-id: 40fd8559-c45f-4b1e-47b1-08ddacd7f94d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?NjojqnMuu4VFFn/m/a6zfip75SAMH8UQtqv695P7BH1G+XiVob9BOKBb7h?=
 =?iso-8859-1?Q?+9RUtNLlo3a2nRY6QzhXW2l51A4oUv4TFmTXDQsg8DxCWaOzFw3lC1Sm6D?=
 =?iso-8859-1?Q?U29DBcnvr9uwUeSWvfMp9154KT4BiT1mNXrml3+e+iDT0SlxVSpuMZxrKq?=
 =?iso-8859-1?Q?aQ70VNF3Xffyd++aTSp3D7czn4leLJKXzXYcLYznf9mwpxOTLWzTXJJEa4?=
 =?iso-8859-1?Q?HTsJ+LvKKwpQJ39hCA26rb6fWq2ZaRFPcKUIfrdwjKf3XIiV0Rc5HgRn39?=
 =?iso-8859-1?Q?vUWs6C6nwv3KN1KGnGjMCC4HU75Y47ZFujdEsGTcEzoK+8yiJ8un9OAtqT?=
 =?iso-8859-1?Q?Edl8631tYvSi2aIjWGylreRh5YRtU2Or48ZGfrkRY+qUNJPn3wtkpHUCgj?=
 =?iso-8859-1?Q?/cBo6UFtpSb0W4m1D+SLvwoBGlHJWZAiVap47LoZ+qjPNUExQjigMPXn8V?=
 =?iso-8859-1?Q?mS8p9FyPY/uWRQflel+JPvS8nTZKvzViYkkA/wSmdxNk08isKniYokbWEg?=
 =?iso-8859-1?Q?IZVIi+ruxlxYJtowe97D7Lg/YQ49bVb/HnfSNJDBrPKygvCPJfsQFcWpc4?=
 =?iso-8859-1?Q?iUi2i/bqLeBEkaAnYS+wJRMJbzGLvlEv9G5A3PM1HLRXuLXDlIsygNnhkJ?=
 =?iso-8859-1?Q?z0AcMY15q2T0kCt/YxxeGLtywSz31LQzaOmd+bpr6rdKKRtpEBhMQbpSvO?=
 =?iso-8859-1?Q?RmDpMBHJJOPq4YoNmK3lieQ+cp5mIV8mlyAbUwFVMrF8+HsNlSQwDbVQXE?=
 =?iso-8859-1?Q?oC7Eut9Rt1I6yMU//2dlzaNyYz676bxMMHnYfwTMM9LCFc1C9P2LYnULh4?=
 =?iso-8859-1?Q?aduiXbLydZZa4o+LbyQAAThkw+ROCwXcUYygOW4rzzypONrHJ9rn8XMJ9Q?=
 =?iso-8859-1?Q?yOGNwlNWO1T09Yyqvxl1iXW3WEqJVZjRZ5VM9UIWJ36EYlpsweT7yzEzY4?=
 =?iso-8859-1?Q?oNBR4ec8hvdRIfsK3pxYyCVaOe6u/8ManzmUDq/B7/LjGjc2nrAvgpqMUx?=
 =?iso-8859-1?Q?7A6AZYsR4r0I37QXx1f9bzbFwCZxCC7uOi8jDPL4hRvm8XOW/EWj/EnTBN?=
 =?iso-8859-1?Q?tc7cdshAxwBiniS3uh++LTUxgrwp5ie9G9SZE5zsuYH19bqkOEQP3IcoAy?=
 =?iso-8859-1?Q?g4tclsYBUA5VA6KiLLFAcf7QZFT7tWOT3X0R3sinsgv0Qm/QA846LqegDL?=
 =?iso-8859-1?Q?knLD9Bx+t2bW6OXAPHge41QiiL16miKqNaMVYdmzXaMjUO2k4xYTloqoa4?=
 =?iso-8859-1?Q?sfLVgOm1j6Ilz3LYA1ILRnMbX2CufKSZLbjAgOAywIvmcWfGWsRJX+HwV6?=
 =?iso-8859-1?Q?TQ1oQ5taGLXfKqWCDdYIjjvFJu5gLnp+d8sYDz7wG4fqEtcTqnrprCB7QJ?=
 =?iso-8859-1?Q?rlTDdkilwN54It5F99f2HJuZWGY0vpZSlVN9golQoXlwgUvcyG3PrQBPDT?=
 =?iso-8859-1?Q?tGSLJ030DfzY7UXhYF3tw+DRL5ltFwY8e7FJHym5QXatmsKkVL5ZsgGcHm?=
 =?iso-8859-1?Q?BZluM75Fp3DIa74B+MDtth8xyaCpP+zCvZ1HmNYNCesQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5MQoCUsHzKPPYAXvrA8V1yLfmvnquA+H9q0EfmIf01ydZ0yu0ZjJjd3aWK?=
 =?iso-8859-1?Q?y8H26RsXUiTVgJdNJQSPn0Z1VEfqyo11Kj7VYJDfhTYv89XxdpGQj9VaG0?=
 =?iso-8859-1?Q?DOGQhDDsPHNLFzMp6k6jzc9mIxPkgNo8+aRmIvDVbfuq6MoyDnR3jFmoX8?=
 =?iso-8859-1?Q?kJMVKYF8b2dXmELtL81OYVk0AMvrxWNnA44jW/p2eyk7GsrovnTxP92KNm?=
 =?iso-8859-1?Q?VP72XFw8ElIo/e9mmiges8EKTS1bFxT9XdyxSO5Miv3XzOCYTHfaMK5U0/?=
 =?iso-8859-1?Q?HFwBfn5cvuog6T+d8hH6OoxYMueCmtzv/l2BXgtxKnOiA+F3r1l6wDXGvu?=
 =?iso-8859-1?Q?3gI+RMjnM3U9kYjE1p/vfQdE0MBa1+tqgyz9GXqZ3Lhgaa0tb8TcU5xtmF?=
 =?iso-8859-1?Q?N2WpPGOSCfzaIqF08vDuXEeqoXeK3PFpl3XP62cC8nK+4SE9JLgDZ/KT2N?=
 =?iso-8859-1?Q?OAegpldJtK8aDsEgblAMnrQXbkceKG0LAWYZt0mMzzynJqKqG3qy8cj4/b?=
 =?iso-8859-1?Q?VqtBtzBePKItdIRbp1CIPvtuqRM3rbERc+N1OABCrmQ4ufH+6QLEW98/N9?=
 =?iso-8859-1?Q?OOxG44ZANfq8EhpNZ/mTPV59eKYNzrooJsQ5WfVPj0xAabQc33r9RqnTnb?=
 =?iso-8859-1?Q?Kf1N1QeoiQP28XCPbQN//4bi3OptH3ca43MHwbs+l/0cWnqyKBGKOBbkga?=
 =?iso-8859-1?Q?JYLa082idnQPfiVPWI5YhI8lj2b8LJzA/OHmvsw49MWBiaUaHwnF07Mdsm?=
 =?iso-8859-1?Q?jNK4XS+LVnXpGqOTjf6AgIb+7V3c1BIKFqXvj1w2CV9SeF/UsiT5tPwcEM?=
 =?iso-8859-1?Q?tPqU+dvuIw+yPHFRWpOzoQKYJsp5qtB/i2eSDjmbQ7wAPyNA7jj5PrnS/q?=
 =?iso-8859-1?Q?TohTJp4vCqnjNZl6eYlhG7xJxldxFW+rofoCl16Fa0t2k/gVgMPfCrMooQ?=
 =?iso-8859-1?Q?AtgbWJvl/6pXbqnSB1dfCkdWj4SHh0ZkT09ym1DX440hidnAOo+ct0slo8?=
 =?iso-8859-1?Q?OxOMgL2ZOQlP5oSP/HwJyqC4DDGc3r94DABIoe3l6mOzK7HWUH2T4MMJBR?=
 =?iso-8859-1?Q?xOcfSI7sB8a/qHs6u4UWE/+FweOTlqWKnncs84Odsi9G6eZ6Leqw64UMni?=
 =?iso-8859-1?Q?ohiBbJ7HKiEppx6nLVDXVDj//UhPOQbI4z77JKwLbz//wslnvYZ9fEb1mN?=
 =?iso-8859-1?Q?ibAkz+9xiqUJKFvN8NZcTu2V//9ARmiAkqBMvp/JLtYWC8yyTE2hqZWenv?=
 =?iso-8859-1?Q?1jTDCr9nW4pR0edb84/WZ2joSXftEBXS4NtZo/cdHfQKFsBlKCPtZIiP7y?=
 =?iso-8859-1?Q?+GMDil8wp84RI1sA5JPIHeKlqN3fIT19xSsW205UHlAVoJzt75Q5L3uMYg?=
 =?iso-8859-1?Q?3tvNtrXQpTH4bSjEwqCM1/eVjoeQ5EhWYadyi+nikglyAs7uBuiUvrbWEW?=
 =?iso-8859-1?Q?dEiWCPNyWi9Z2nqYaZKaBfHOL4zjCOxQn9glAb3AGCNfkyU4666EPN9WgB?=
 =?iso-8859-1?Q?InqiPMXCrUt1K+yqTNVoj/hCgf6Bxi1VW8vyXR7KgUVYzbShfH1YqH4tcZ?=
 =?iso-8859-1?Q?0T4r7bR63qt/Morj6weCvD5j71/AoGsMJDNP6DrJrOvOOIgQ8EsoN7nugT?=
 =?iso-8859-1?Q?HF3bABF6qz6a4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fd8559-c45f-4b1e-47b1-08ddacd7f94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 13:16:15.6775 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ornwPM77xiPJJO5vH89IpKu1IbCkkJWso7cjZDYHyCp12Td4fmmcaSelmHQhIFLKq9eA/Z36gv2nfMsEhnWOdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 74c=
623c8bbfcaf5a49a25dd17a7fbe63d2b21e5d -> drm/amdgpu: add kicker fws loading=
 for gfx11/smu13/psp13) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

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
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, June 11, 2025 2:40 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/10] DC Patches for 16 June 2025

DC v3.2.338 highlights:

* DML bug fixes
* Add pwait to DMCUB hang reporting
* New definitions / changes to prep for new platforms.
* Misc cleanups

_________________

Alex Hung (1):
  drm/amd/display: Check dce_hwseq before dereferencing it

Charlene Liu (1):
  drm/amd/display: add APG struct to stream_enc for future use

Karthi Kandasamy (1):
  drm/amd/display: prepare for new platform

Mario Limonciello (2):
  drm/amd/display: Use scaling for non-native resolutions on eDP
  drm/amd/display: Disable common modes for eDP

Nicholas Kazlauskas (1):
  drm/amd/display: Add pwait status to DMCUB diagnostics

Ryan Seto (1):
  drm/amd/display: Removing Unused DPP Functions

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.338

Yan Li (2):
  drm/amd/display: apply two different methods to validate modes
  drm/amd/display: remove use_native_pstate_optimization

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  18 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +-
 .../dc/dml2/display_mode_core_structs.h       |   1 +
 .../display/dc/dml2/dml2_translation_helper.c |  19 --
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    | 242 +++---------------
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |   2 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   2 -
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |  24 --
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   2 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 +
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   2 +-
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.h  |   8 +
 .../dc/resource/dcn32/dcn32_resource.c        |   1 -
 .../dc/resource/dcn321/dcn321_resource.c      |   1 -
 .../dc/resource/dcn35/dcn35_resource.c        |   1 -
 .../dc/resource/dcn351/dcn351_resource.c      |   1 -
 .../dc/resource/dcn36/dcn36_resource.c        |   1 -
 .../dc/resource/dcn401/dcn401_resource.c      |   1 -
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   5 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   5 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |   5 +-
 23 files changed, 78 insertions(+), 269 deletions(-)

--
2.49.0


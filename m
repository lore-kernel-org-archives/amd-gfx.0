Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6026CCF9E5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 13:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4298B10E497;
	Mon, 27 Oct 2025 13:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wIuhLZdi";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011007.outbound.protection.outlook.com
 [40.93.194.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89B910E497
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Oct 2025 13:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnjuU1hhDJKfyYlvS5zm7udNvAitP/t+dXaeQwcF+bwdGLq/GuPcXgc5AGl9vy9zfaFhkIjVaw0rUPmuKhxWOe8PZjyF2XxGujsaqL3eyoCEk8HtRMsRDxofnEOfs7JdyHOxksgCLIi+tbZ1jgpsmGYuUnvv8WhIF/v2IO/TnlMczINpNTZxTXcA+sN5Un/ROLlhKfSL+yH5vjhttik+HMVYkvpCRmzucKNN+fEwIeswFprRDZELOYMMaw546oRDr1xxxGI0ktuhmngvXzGbUOxDiAfPc5BwVkg63drNpnrqhN7eIyM1mhCM1HCQT1C0bpx3fEwXbpw+gtKJlBmITA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ESc/k4qwU48bwWLh7aXG+oMar8snkTlrfl7wQvQZPWc=;
 b=rF9BpoHIPNFJwWllzU1z1W7uKJBp1qQheOVIATnIVUvV5yY3VdPHO+U2PR2lLwQ/eBS7j2Bz5C/NThd8GdzDz/YMd2fzBEdlsTiTJr5LnjG48Y/W/lapdq7nySH8Vp3y1PRmS1tbJ9jq52IzJcz93guzZc6OF4dKswKkauG3faBLsjcBbObVIZPaar4Ftt7pwmP+ndMpIKInlHyepzOo16DtXb5P4g5d+OWznF4kh4kdgl7/9hjv2fe1VmzTh2Mg23zDQciWc4k54gMfQzr9wikIJJ5rcQj6WzHcZZ2k4/JeKOhk75YzvV/zcpk08QF+g43IUQyeA6tzQD2RvOVHQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ESc/k4qwU48bwWLh7aXG+oMar8snkTlrfl7wQvQZPWc=;
 b=wIuhLZdiV+huJcDc1cg19ypjrXFusVhJEMz4YUcSQ1+WVRVd+4pSU/212ldVKoCj/UU8zJs7jpPZVydxtmvqCwK01MR1HkIoJOrYs4NGAlpSp2aGo643AF2EZ6iFgWwsJrVVjNHvDqt1/vpI16pJnJVKUS2dECkH1SWQK3vH7HI=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB7221.namprd12.prod.outlook.com (2603:10b6:806:2bd::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Mon, 27 Oct 2025 13:24:30 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%7]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 13:24:29 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/20] DC Patches October 27, 2025
Thread-Topic: [PATCH 00/20] DC Patches October 27, 2025
Thread-Index: AQHcQyY5qBC0zXZyyEayd4Ln4TU1RLTWA3YQ
Date: Mon, 27 Oct 2025 13:24:29 +0000
Message-ID: <DS0PR12MB6534236FC68555383425B5CD9CFCA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20251022073332.666119-1-Wayne.Lin@amd.com>
In-Reply-To: <20251022073332.666119-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-10-27T13:23:44.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA1PR12MB7221:EE_
x-ms-office365-filtering-correlation-id: a4a84f41-83fc-417c-7527-08de155c28a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?vtYOXZLL0QZYZkxa7uI96+a6f1VBD9gP5hViWOsaoBvqbmZwWR7ejYVJYzlg?=
 =?us-ascii?Q?BmK8TDoIiHHl8Ky923s1pUqGRrlJe49UdLPi/tFd3RWWIVQzc56dJcJds9F3?=
 =?us-ascii?Q?Y4k0IRgwePN9Ykxklilpbud/9Sy8XcH9WKAgLCP3E0k9/WJTbu//2PDUyFkN?=
 =?us-ascii?Q?4JDVswdWeAF8KYnE9ozekwd9R49JFMwc5aZCeIDhseWHis5u9e3XDLrgT+Sn?=
 =?us-ascii?Q?l/3vaUlArVtWaIN71fBPUWhDqpjN5VQLrAiCEBMWFyaKXiVHJ4vkU62ImPsl?=
 =?us-ascii?Q?owAYdkrDAUucSv6IpqJYRHyU7F6Bjv6kkLKS8CA5swD+zOij1Kw5vzTF5NAF?=
 =?us-ascii?Q?6of+nkJgNBBhtY93vNvGW7R3YhxfZ1UBgDLViXcznXnVrmR5eivbsJrpGRnI?=
 =?us-ascii?Q?w5dR4qDGMoNI9L6flCc9xvW690pd6YjMP+YJ5//nwPMf6tjEXUUrTXoedmbC?=
 =?us-ascii?Q?j8luDcHg0kG0xasQnamoJfFkYnfOf0rRZw17dxkiVa3TcJXJD0/A7EVjirbo?=
 =?us-ascii?Q?Pfw0NcFMwoZdsF1J8+53szN19SDx49EPPkcMEwNUsq2nB0qN3Mj6dobR8/mv?=
 =?us-ascii?Q?GGRTr8vI60uPSsJwcqdBW/86A6PfJbRrbMrgilgJxVF4wJLrUlOVoSKiAGQN?=
 =?us-ascii?Q?aP5OYl8GFvl+lYC/54KLTTvbLGQ0MGw4oaIxuOTO0apKbKkCdvWEbUUCd/v5?=
 =?us-ascii?Q?23vaJPZvLa2Q7cm9rj5dfy4ylidFL1qhFrLQjZ2JM7Y+D9TaJ+1i6wbAxcCj?=
 =?us-ascii?Q?/taDosE0lkjf+yzSC9kDQmAfLft5Xtna28GaW5Ux9lHl5glEOf+18RMom5kC?=
 =?us-ascii?Q?jqhk/PqNKYOSyGAGxiviZguKYT/IgpsrHf2As4sU92998xM+KLeTAcqWCJnj?=
 =?us-ascii?Q?dA7KE4F0qzc6tmrA7omO3VpGbJ1LyTFdV49ywj+6OjBbkck+Oz9ZUp0GhYqK?=
 =?us-ascii?Q?mIqBpIPHdJ8da3ikd0wlx/lvEQczhreL+jDjwK9rQ+FMC7aC4A0ePR94KFHP?=
 =?us-ascii?Q?9gprAi5a4KZVASOgMFTI1tZmST5DbXQkpyKcIBS7TLGcQfwDIjAohVfD5NS6?=
 =?us-ascii?Q?KJ8bVNYu5L5F0wMOf3o7UIOe8WMA9Fw0sBOG9zHLaz/gIh7IIvlm3GoQJgNB?=
 =?us-ascii?Q?/n7eVN26i/M7Y5OWoMHuyGhkJ4u4IpFaZFamoKqhcIUxOyhyGIIZYdAOBwzw?=
 =?us-ascii?Q?rha1plAwwjKd1ddJsQF+FnNe9WchM8ujQK9Kh8B+7g8P0eWi2zk9vpzKMUKn?=
 =?us-ascii?Q?r+6VcMzSntOP4wFaotiWl2vO9MkOWrHYyen9VCN2rlCs72X85xT6xVp50VfP?=
 =?us-ascii?Q?DJQS+iIooWulhK2P4bKuz4UXVjV6UyaFHm6TKdL+tc3pl8H49XgH7U5gv76C?=
 =?us-ascii?Q?H3CoEk1tWTUU2ACUkdP/XUGCb9oT63eGUG532bvb1m5gFOQe9Fc+7GvgYWRQ?=
 =?us-ascii?Q?4jAPhgcoDllmzZp6Bq3HA6QeB9ofMNg69QhRMeB1/Vd0rYBSRBf2NGmCHXyP?=
 =?us-ascii?Q?x3p+hw0y09cMGLILnZe2uvY6e9EjWbd5RbzN?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HZSYt/2dSyxN24suonADcZxlFKpUhopoZPOIflhpWL3Bp3vZFHslB9jWMdEh?=
 =?us-ascii?Q?ee5exCGbvcyXoIU9pUzw6bZUr3LRinXGZqR8xgdTwV1UCjeZrsYpE74eHOCi?=
 =?us-ascii?Q?pDuxde1RGK+3d9KFbsB3AELZg3aXENi8wqKjcqHJRLSXiweltKgJ0mRofwqO?=
 =?us-ascii?Q?Tk7t3Uvq93/oFspZKJIxb0ge9PTJ3GyrmIdZTYKRnul0emZvFIss9J9Y/6HQ?=
 =?us-ascii?Q?PFJreNEc7PEi8DRgWj28oW2lDDBMjOZf+gGc+2w6Q7VPZd8sxezGK1BN5+dA?=
 =?us-ascii?Q?u+n/NE6Ja7AEuYu0teUr1eXQu7iw4mrsnS8cHZLzhZzpw0eaG/LwqGdM9zG3?=
 =?us-ascii?Q?IuxTHnN9Pt6yi8X9on9wf+lFJoZMRVuHvSC1SIdSOY5fZy8yfP1mRyYMiCZo?=
 =?us-ascii?Q?CelEGBV+lUdJ8VkEndmM7SVA2K0//uIEsnWzhYrYINJ1dPdKqMtJfvU6isOk?=
 =?us-ascii?Q?5cZJ3nH1KxbJJYuYaIDuuRBwMLtKrcZqq7rEuNCD738QomA1iGs9iFb1QwXU?=
 =?us-ascii?Q?PgKPW1KjseWuFmvsbCie7bLQR6bzBT/YCO/dOwvTBXcpP54QDMB4qHDw51so?=
 =?us-ascii?Q?SY4kKi6B4CSZq+PNIBf0QTihBoavlBmkZvH39hhwwKYFRb0OjgKFAFJFZnVf?=
 =?us-ascii?Q?L4egTqrSzc8JZ/6yXOMfKSqZbt8zOGAtuDw+MwsSgmyKla3tCC6AG9/WhgZl?=
 =?us-ascii?Q?7bH6eth+xgqpf64guR0hR15o4f1qFqbx7m484sHvlvnCOwmEwhRdHenUDIl+?=
 =?us-ascii?Q?wuJrA0DdAKdudde7eMBkdgnOka7+LH7gUME0MVKvLHpTsk50MBbfKe1PHxP+?=
 =?us-ascii?Q?fsPTq6pvoQc2LlnI3Ns7sQPYiB974Zt5xaLLsbVkbRSJXGpbQIivtSkh0SE6?=
 =?us-ascii?Q?nIaNbM4GLUBsHTA2g3arVVfjYlw4q4wtKKanZ8fohwuWQrcDp/FAQtsEYfru?=
 =?us-ascii?Q?Y4YPJUr8iYPSv19J80OSYMPxVmzrR+66ntTgQ+WO1HuaqjrLXfQkIVOEPoM0?=
 =?us-ascii?Q?KYW7QBf8t/XWo28o2ctj/g52dsAfsRVG6RHoZDGP7/72kdNtkabOMpg/Ge0d?=
 =?us-ascii?Q?3M5zIGga7ZwThka6h9LB//UzY1pn0cUYHsT6djNChC+Fh+gURN1PDUNgoEK/?=
 =?us-ascii?Q?JGmp6N8qT++KB2Pn8Givfv0gFJqtfMvVpPqS/56wxZ39muS1be8bNJ6KHm/q?=
 =?us-ascii?Q?ZdCQqCM8x/xkjoMy1ALwU6rDs6uv9H5tIZfYQz71DNBhtSkEdT7kVWrlo1vy?=
 =?us-ascii?Q?oW+0mbh2hsMvXni3aEZzrv0AkxfGsvpdMucabKuafsykO+XWEqD9aTLGkZVf?=
 =?us-ascii?Q?regH5pTjc43XRl/E8mi5SZHAT5V7asQAXL0Dr6RZUN1SLeM1/CB8d/xs6SkO?=
 =?us-ascii?Q?AzRLufxqtV8ouPAzlsV5nlAD0mmG/ZL2hJUjVftIezo+dbI0k77/NjPBKHFR?=
 =?us-ascii?Q?ymS2zfSSk3z7oOHOXgFq6DlIl7GcaxgQOTyo2NLxionXWIiO4Kx1gNCTnEvu?=
 =?us-ascii?Q?SeSUxoBgxSCE9SHNiS4jseEfnIB42MEYtHY5ebODtj15kaoLx0UyB/2gJKde?=
 =?us-ascii?Q?qAH7Heg/wUCzRB9kAxA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a84f41-83fc-417c-7527-08de155c28a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 13:24:29.5785 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvNYq+k4ruQLzNDhvwlG4GrWLBg1rS1PWjOT/n0S73yX0+TM5k4QzVFjuPaT8/7Mmzbgbrb031Tb33xY5qPIfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7221
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
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
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
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - 46d=
d134bb2493e78fdc83622d8f9e2ed41c81518 -> drm/amdgpu: clear bad page info of=
 ras module) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: waynelin <Wayne.Lin@amd.com>
Sent: Wednesday, October 22, 2025 3:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
Subject: [PATCH 00/20] DC Patches October 27, 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Fix incorrect return of vblank enable on unconfigured crtc
- Add HDR workaround for a specific eDP
- Make observers const-correct
- Add lock descriptor to check_update
- Update cursor offload assignments
- Add dc interface to log pre os firmware information
- Init dispclk from bootup clock for DCN315
- Remove dc param from check_update
- Update link encoder assignment
- Add more DC HW state info to underflow logging
- Rename dml2 to dml2_0 folder
- Fix notification of vtotal to DMU for cursor offload
- Fix wrong index for DCN401 cursor offload
- Add opp count validation to dml2.1
- Fix DMUB reset sequence for DCN32
- Bump minimum for frame_warn_limit

---

Alex Hung (1):
  drm/amd/display: Add HDR workaround for a specific eDP

Alvin Lee (1):
  drm/amd/display: Update cursor offload assignments

Austin Zheng (3):
  drm/amd/display: Add dml2_0 folder
  drm/amd/display: Update dml2 references to use dml2_0 folder
  drm/amd/display: Remove dml2 Folder.

Dillon Varone (1):
  drm/amd/display: Fix DMUB reset sequence for DCN32

Dmytro Laktyushkin (1):
  drm/amd/display: Add opp count validation to dml2.1

Dominik Kaszewski (3):
  drm/amd/display: Remove dc param from check_update
  drm/amd/display: Add lock descriptor to check_update
  drm/amd/display: Make observers const-correct

Ivan Lipski (1):
  drm/amd/display: Fix incorrect return of vblank enable on unconfigured
    crtc

Karen Chen (1):
  drm/amd/display: Add more DC HW state info to underflow logging

Mario Limonciello (1):
  drm/amd/display: Bump minimum for frame_warn_limit

Meenakshikumar Somasundaram (2):
  drm/amd/display: update link encoder assignment
  drm/amd/display: Add dc interface to log pre os firmware information

Nicholas Kazlauskas (2):
  drm/amd/display: Fix wrong index for DCN401 cursor offload
  drm/amd/display: Fix notification of vtotal to DMU for cursor offload

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.33.0
  drm/amd/display: Promote DC to 3.2.356

Zhongwei Zhang (1):
  drm/amd/display: init dispclk from bootup clock for DCN315

 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |  87 ++++++-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.h        |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 220 ++++++++++--------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  45 +++-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   8 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  68 ++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  21 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   7 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  11 +-
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |  64 ++++-
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    | 123 ++++++++++
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.h    |   2 +
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   3 +-
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.h  |   3 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |   1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |   5 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  | 141 -----------
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    | 140 +++++++++++
 .../display/dc/{dml2 =3D> dml2_0}/cmntypes.h    |  18 +-
 .../dc/{dml2 =3D> dml2_0}/display_mode_core.c   |   2 +
 .../dc/{dml2 =3D> dml2_0}/display_mode_core.h   |   0
 .../display_mode_core_structs.h               |   3 +-
 .../display_mode_lib_defines.h                |   2 +-
 .../dc/{dml2 =3D> dml2_0}/display_mode_util.c   |   0
 .../dc/{dml2 =3D> dml2_0}/display_mode_util.h   |   2 -
 .../dml21/dml21_translation_helper.c          |   0
 .../dml21/dml21_translation_helper.h          |   0
 .../dc/{dml2 =3D> dml2_0}/dml21/dml21_utils.c   |   0
 .../dc/{dml2 =3D> dml2_0}/dml21/dml21_utils.h   |   0
 .../dc/{dml2 =3D> dml2_0}/dml21/dml21_wrapper.c |   4 +-
 .../dc/{dml2 =3D> dml2_0}/dml21/dml21_wrapper.h |   0
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |   1 -
 .../dml21/inc/dml2_external_lib_deps.h        |   0
 .../dc/{dml2 =3D> dml2_0}/dml21/inc/dml_top.h   |   0
 .../dml21/inc/dml_top_dchub_registers.h       |   0
 .../dml21/inc/dml_top_display_cfg_types.h     |   0
 .../dml21/inc/dml_top_policy_types.h          |   0
 .../dml21/inc/dml_top_soc_parameter_types.h   |   0
 .../dml21/inc/dml_top_types.h                 |   0
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |   1 +
 .../dml21/src/dml2_core/dml2_core_dcn4.h      |   0
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  29 ++-
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |   0
 .../dml21/src/dml2_core/dml2_core_factory.c   |   0
 .../dml21/src/dml2_core/dml2_core_factory.h   |   0
 .../src/dml2_core/dml2_core_shared_types.h    |   3 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |   0
 .../dml21/src/dml2_core/dml2_core_utils.h     |   0
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |   0
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h      |   0
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   0
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.h   |   0
 .../dml21/src/dml2_mcg/dml2_mcg_dcn4.c        |   0
 .../dml21/src/dml2_mcg/dml2_mcg_dcn4.h        |   2 +-
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   0
 .../dml21/src/dml2_mcg/dml2_mcg_factory.h     |   0
 .../dml21/src/dml2_pmo/dml2_pmo_dcn3.c        |   0
 .../dml21/src/dml2_pmo/dml2_pmo_dcn3.h        |   0
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |   0
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h  |   0
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   0
 .../dml21/src/dml2_pmo/dml2_pmo_factory.h     |   2 +-
 .../lib_float_math.c                          |   0
 .../lib_float_math.h                          |   0
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |   0
 .../dml21/src/dml2_top/dml2_top_legacy.c      |   0
 .../dml21/src/dml2_top/dml2_top_legacy.h      |   0
 .../dml21/src/dml2_top/dml2_top_soc15.c       |   0
 .../dml21/src/dml2_top/dml2_top_soc15.h       |   0
 .../dml21/src/inc/dml2_debug.h                |   0
 .../src/inc/dml2_internal_shared_types.h      |   0
 .../{dml2 =3D> dml2_0}/dml2_dc_resource_mgmt.c  |   0
 .../{dml2 =3D> dml2_0}/dml2_dc_resource_mgmt.h  |   0
 .../dc/{dml2 =3D> dml2_0}/dml2_dc_types.h       |   0
 .../dc/{dml2 =3D> dml2_0}/dml2_internal_types.h |   2 +-
 .../dc/{dml2 =3D> dml2_0}/dml2_mall_phantom.c   |   1 +
 .../dc/{dml2 =3D> dml2_0}/dml2_mall_phantom.h   |   0
 .../display/dc/{dml2 =3D> dml2_0}/dml2_policy.c |   0
 .../display/dc/{dml2 =3D> dml2_0}/dml2_policy.h |   0
 .../dml2_translation_helper.c                 |   3 +
 .../dml2_translation_helper.h                 |   0
 .../display/dc/{dml2 =3D> dml2_0}/dml2_utils.c  |   0
 .../display/dc/{dml2 =3D> dml2_0}/dml2_utils.h  |   0
 .../dc/{dml2 =3D> dml2_0}/dml2_wrapper.c        |   0
 .../dc/{dml2 =3D> dml2_0}/dml2_wrapper.h        |   0
 .../display/dc/{dml2 =3D> dml2_0}/dml_assert.h  |   0
 .../dc/{dml2 =3D> dml2_0}/dml_depedencies.h     |   1 +
 .../dml_display_rq_dlg_calc.c                 |   0
 .../dml_display_rq_dlg_calc.h                 |   0
 .../display/dc/{dml2 =3D> dml2_0}/dml_logging.h |   1 +
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   4 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  16 ++
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |   2 +
 .../drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c  |   1 +
 .../drm/amd/display/dc/dpp/dcn35/dcn35_dpp.c  |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |   1 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   1 +
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   8 +
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.h  |   1 +
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   1 +
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dsc.h      |   5 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |  33 +--
 .../display/dc/hubbub/dcn30/dcn30_hubbub.h    |   6 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |   3 +-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |   3 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.h    | 136 ++++++++++-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |   8 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    | 147 +++++++++---
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.h    |   2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |   4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  28 +--
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |   2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  76 +++---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   4 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  | 121 +++++++++-  .../gpu/dr=
m/amd/display/dc/inc/hw/dchubbub.h  |  12 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |  16 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |   5 +-
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  27 +++
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  13 ++
 .../amd/display/dc/inc/hw/timing_generator.h  | 130 +++++++++++  .../drm/a=
md/display/dc/mpc/dcn30/dcn30_mpc.c  |  16 ++
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.h  |   5 +
 .../drm/amd/display/dc/mpc/dcn32/dcn32_mpc.c  |   1 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |   1 +
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.c  |  14 +-
 .../drm/amd/display/dc/opp/dcn10/dcn10_opp.h  |   6 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |  13 ++
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.h  |   6 +-
 .../drm/amd/display/dc/opp/dcn35/dcn35_opp.c  |  13 ++
 .../drm/amd/display/dc/opp/dcn35/dcn35_opp.h  |   4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |  38 ++-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    | 131 +++++++++++
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |   2 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.c  |   1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  |   1 +
 .../dc/resource/dce100/dce100_resource.c      |   7 +-
 .../dc/resource/dce110/dce110_resource.c      |   5 +-
 .../dc/resource/dce112/dce112_resource.c      |   7 +-
 .../dc/resource/dce120/dce120_resource.c      |   8 +-
 .../dc/resource/dce80/dce80_resource.c        |   8 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   7 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   6 +-
 .../dc/resource/dcn201/dcn201_resource.c      |   6 +-
 .../dc/resource/dcn21/dcn21_resource.c        |   6 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   6 +-
 .../dc/resource/dcn301/dcn301_resource.c      |   6 +-
 .../dc/resource/dcn302/dcn302_resource.c      |   6 +-
 .../dc/resource/dcn303/dcn303_resource.c      |   6 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   6 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   6 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   7 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   6 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   8 +-
 .../dc/resource/dcn321/dcn321_resource.c      |   6 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   8 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   8 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   8 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   8 +-
 .../dcn401/dcn401_soc_and_ip_translator.h     |   2 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  25 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  12 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |  50 ++--  .../gpu/drm/amd/=
display/dmub/src/dmub_dcn35.c |  39 ++++
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |   2 +
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |  17 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   9 +
 182 files changed, 1920 insertions(+), 530 deletions(-)  delete mode 10064=
4 drivers/gpu/drm/amd/display/dc/dml2/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
 rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/cmntypes.h (93%) =
 rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/display_mode_core=
.c (99%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/display_=
mode_core.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0=
}/display_mode_core_structs.h (99%)  rename drivers/gpu/drm/amd/display/dc/=
{dml2 =3D> dml2_0}/display_mode_lib_defines.h (95%)  rename drivers/gpu/drm=
/amd/display/dc/{dml2 =3D> dml2_0}/display_mode_util.c (100%)  rename drive=
rs/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/display_mode_util.h (99%)  ren=
ame drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/dml21_translati=
on_helper.c (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0=
}/dml21/dml21_translation_helper.h (100%)  rename drivers/gpu/drm/amd/displ=
ay/dc/{dml2 =3D> dml2_0}/dml21/dml21_utils.c (100%)  rename drivers/gpu/drm=
/amd/display/dc/{dml2 =3D> dml2_0}/dml21/dml21_utils.h (100%)  rename drive=
rs/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/dml21_wrapper.c (99%)  r=
ename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/dml21_wrapper=
.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/i=
nc/bounding_boxes/dcn4_soc_bb.h (99%)  rename drivers/gpu/drm/amd/display/d=
c/{dml2 =3D> dml2_0}/dml21/inc/dml2_external_lib_deps.h (100%)  rename driv=
ers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/inc/dml_top.h (100%)  r=
ename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/inc/dml_top_d=
chub_registers.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> d=
ml2_0}/dml21/inc/dml_top_display_cfg_types.h (100%)  rename drivers/gpu/drm=
/amd/display/dc/{dml2 =3D> dml2_0}/dml21/inc/dml_top_policy_types.h (100%) =
 rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/inc/dml_top=
_soc_parameter_types.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =
=3D> dml2_0}/dml21/inc/dml_top_types.h (100%)  rename drivers/gpu/drm/amd/d=
isplay/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_core/dml2_core_dcn4.c (99%)  re=
name drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_core/=
dml2_core_dcn4.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> d=
ml2_0}/dml21/src/dml2_core/dml2_core_dcn4_calcs.c (99%)  rename drivers/gpu=
/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_core/dml2_core_dcn4_c=
alcs.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml=
21/src/dml2_core/dml2_core_factory.c (100%)  rename drivers/gpu/drm/amd/dis=
play/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_core/dml2_core_factory.h (100%)  =
rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_cor=
e/dml2_core_shared_types.h (99%)  rename drivers/gpu/drm/amd/display/dc/{dm=
l2 =3D> dml2_0}/dml21/src/dml2_core/dml2_core_utils.c (100%)  rename driver=
s/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_core/dml2_core_u=
tils.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml=
21/src/dml2_dpmm/dml2_dpmm_dcn4.c (100%)  rename drivers/gpu/drm/amd/displa=
y/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.h (100%)  rename=
 drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_dpmm/dml2=
_dpmm_factory.c (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dm=
l2_0}/dml21/src/dml2_dpmm/dml2_dpmm_factory.h (100%)  rename drivers/gpu/dr=
m/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_mcg/dml2_mcg_dcn4.c (100=
%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2=
_mcg/dml2_mcg_dcn4.h (97%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D=
> dml2_0}/dml21/src/dml2_mcg/dml2_mcg_factory.c (100%)  rename drivers/gpu/=
drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_mcg/dml2_mcg_factory.h=
 (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src=
/dml2_pmo/dml2_pmo_dcn3.c (100%)  rename drivers/gpu/drm/amd/display/dc/{dm=
l2 =3D> dml2_0}/dml21/src/dml2_pmo/dml2_pmo_dcn3.h (100%)  rename drivers/g=
pu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_pmo/dml2_pmo_dcn4_f=
ams2.c (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml=
21/src/dml2_pmo/dml2_pmo_dcn4_fams2.h (100%)  rename drivers/gpu/drm/amd/di=
splay/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_pmo/dml2_pmo_factory.c (100%)  r=
ename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_pmo/=
dml2_pmo_factory.h (97%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> =
dml2_0}/dml21/src/dml2_standalone_libraries/lib_float_math.c (100%)  rename=
 drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_standalon=
e_libraries/lib_float_math.h (100%)  rename drivers/gpu/drm/amd/display/dc/=
{dml2 =3D> dml2_0}/dml21/src/dml2_top/dml2_top_interfaces.c (100%)  rename =
drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_top/dml2_t=
op_legacy.c (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0=
}/dml21/src/dml2_top/dml2_top_legacy.h (100%)  rename drivers/gpu/drm/amd/d=
isplay/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_top/dml2_top_soc15.c (100%)  re=
name drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml21/src/dml2_top/d=
ml2_top_soc15.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dm=
l2_0}/dml21/src/inc/dml2_debug.h (100%)  rename drivers/gpu/drm/amd/display=
/dc/{dml2 =3D> dml2_0}/dml21/src/inc/dml2_internal_shared_types.h (100%)  r=
ename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml2_dc_resource_mg=
mt.c (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml2_=
dc_resource_mgmt.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D>=
 dml2_0}/dml2_dc_types.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml=
2 =3D> dml2_0}/dml2_internal_types.h (99%)  rename drivers/gpu/drm/amd/disp=
lay/dc/{dml2 =3D> dml2_0}/dml2_mall_phantom.c (99%)  rename drivers/gpu/drm=
/amd/display/dc/{dml2 =3D> dml2_0}/dml2_mall_phantom.h (100%)  rename drive=
rs/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml2_policy.c (100%)  rename d=
rivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml2_policy.h (100%)  rena=
me drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml2_translation_helpe=
r.c (99%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml2_tr=
anslation_helper.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D>=
 dml2_0}/dml2_utils.c (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =
=3D> dml2_0}/dml2_utils.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dm=
l2 =3D> dml2_0}/dml2_wrapper.c (100%)  rename drivers/gpu/drm/amd/display/d=
c/{dml2 =3D> dml2_0}/dml2_wrapper.h (100%)  rename drivers/gpu/drm/amd/disp=
lay/dc/{dml2 =3D> dml2_0}/dml_assert.h (100%)  rename drivers/gpu/drm/amd/d=
isplay/dc/{dml2 =3D> dml2_0}/dml_depedencies.h (99%)  rename drivers/gpu/dr=
m/amd/display/dc/{dml2 =3D> dml2_0}/dml_display_rq_dlg_calc.c (100%)  renam=
e drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml_display_rq_dlg_calc=
.h (100%)  rename drivers/gpu/drm/amd/display/dc/{dml2 =3D> dml2_0}/dml_log=
ging.h (99%)

--
2.43.0


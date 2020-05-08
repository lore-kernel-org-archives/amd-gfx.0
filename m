Return-Path: <SRS0=8BNM=6W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E13C38A2A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 09:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82676208CA
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2020 09:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DiMhj1Rm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82676208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3403B6EAB5;
	Fri,  8 May 2020 09:17:49 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 727C86EAB5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2020 09:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVFRHaEoomRv01kbiPvy7epDFNnrSxdailJNZr6WrcbDRInTcBL6fY/t+1GT2TTtf5mnNBY35dar37/kgqHnlc7k9cI7BJn6ycWo37ejIfF3SI8HF4CBdeylyitYrLnOBeb+ym5sxU6lVqIdI9RoQW1wWghjOqGi+nyiVr9wU7KpqdSXhXy86+/Df2pJLhquX3mDNqLxzF2XrfUh7jJcy5E4J9B3nrIBfyiIBGxxtPLvxHcfauduwBEnfQumunafKhLXkKFEOCpYiWGAZq8O6IZ6qkm4KxwFnyA/REQVJNqKFmBirL9lR+xXWNlJgh6slnp1RRa9o+oBKNsNm5d8pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky4xz+O061O9cLTifJhfBdotQNv/gIueZvvxG2ncmdw=;
 b=RuKrjyVdsn2lEfkh9tGETy5dmyztPT16x6wqNYwzCRzb/09iExx/9saTOdeyS6LyVDcdZtliBx1Bbw0QWzbUyiHfvyMEW4rtZIV3PYf9YdgJsgJ8/lXtqoGr2T/IqMETJ2ZafDPBJ74S8Sk49bdnrqI0VVZ40XsuJDuSC1f8Zi42jGzjIJxWCG2ddDReZ7bbHPvcpLMFP6pffFK5wIhwSZWTNAAQ4JGaQ9SHf16GXLd2KTiGS+1U+XrNV5amB3GB+oWZEyxPuVBBZlHrMvOcAP2q2Iqx7x5GGYHVqaXnYZWC3OJdof7L4eREq3ooNqiQpCrQ/n5CbSjNWGtOQD7Xrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ky4xz+O061O9cLTifJhfBdotQNv/gIueZvvxG2ncmdw=;
 b=DiMhj1RmhbWijL4G2EXqMjAH9yT/W/5m3mo6zR//AIPOQVnIllFWW9ZPWsBbAlcoY0vLYzbso/z1y0XwdtjjKBiwq/vyGTxneQfpItM7MPIDgTmP7gvdokraLIY0UTqT3P6V5/mhxJN47VRg6ReCYRmU6HVMj+Df30jw8cgZ7Ls=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2682.namprd12.prod.outlook.com (2603:10b6:5:42::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Fri, 8 May
 2020 09:17:46 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.033; Fri, 8 May 2020
 09:17:46 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: cleanup sysfs file handling
To: Nirmoy Das <nirmoy.aiemd@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200508084841.10157-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d3ed391d-9c43-1188-138e-2aa8dc3de151@amd.com>
Date: Fri, 8 May 2020 11:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200508084841.10157-1-nirmoy.das@amd.com>
Content-Language: en-US
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.31 via Frontend Transport; Fri, 8 May 2020 09:17:45 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5577a620-cb26-4e5b-a5fe-08d7f330ab87
X-MS-TrafficTypeDiagnostic: DM6PR12MB2682:|DM6PR12MB2682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2682E8BD0DA4F4DAB0A97F3983A20@DM6PR12MB2682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-Forefront-PRVS: 039735BC4E
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kIShBUU1e3qmf8FlRWfhmUvfTTh8lf7MrqDEUw7yjq/Y7WomX1UwNPCJOqCj1ACVSEJgdLMlTxiavncscNaDkUpeS8MiJndlihRLAEMLbK4YQzRLmaF8mhKcf05aJwYd685mt/qEtKaSU75tdsMF14yTurkVNOh+PSrhyy4j+jy9ALnFw0lMLVIGWQxfbdbzi265ymI/nQwU2fsS61EtcUmuk98BCnomep0FH/7O20nQViVP2Y5tkK57VSpi4dcw4EQHX9DF1ss1JQ9MR4nWFgd4yejc7WWUcvWF2a5Yy4rvy5F0lP+SgqM+qHSImGNeZQuZRqn/egE/D0Xo5BJgF7/YKxjvnPjq6qEn2MLxixRMJYp+hysi53tKSM5KNusSf3GiUCFzSAJF4vvpujv21dUHlDTI9epl1QxyDsEJ4SWnw64XNsve8S8BOssdsTEnvnuuMoI6QIhhEfX2VNe9MzpeCJZTyrjvsHvDj41Mtg3mbe7EbjEO+MMiWxpEQB695lhZVCC9u0QBeZ56EmaCJusP05NmQU2cEtctlsWX5YDcH9DY94ApmYcFjslQsrGS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(33430700001)(31686004)(16526019)(66476007)(33440700001)(86362001)(5660300002)(2616005)(83310400001)(83290400001)(83280400001)(36756003)(8676002)(83320400001)(83300400001)(8936002)(66556008)(2906002)(4326008)(186003)(66946007)(52116002)(6486002)(31696002)(316002)(6666004)(478600001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 4oGrbOzy+DKfpfAhLVoD2OT+h2Zowzdvn1c6KLRZ/E3iGw8tKKj4jS9zpIEl9m7tH87X0Neb+kLJNJ1PRl4rgG31QT1+NGtM6QBYka8NKdZQznN0N0qE1UtDmYezuZQa5f6PuNh4fas9u/K84g/batQZ9yQqMJa9QC2VvfPbTjG7+4MTM+fpsds7k41BXDSdy/VrEB+hDX7Rk8rnxm3A83JFtE5SNrC8dikRbGp9u64oE4YiXG37+DLiNO26545ij+FK9uikAT1PxqY79QzRE062xN2gw6oRgi+s1rsUcfecaZPtrmkqO+8miPo4TnHNslZK0yNuhXDULW9hGcWqDwXhPm5yxRUumYWejQVS9PmLa9R8JYzG/GzFKT/70OB2J1WbiXYlfZyHrdSnAgeS19wI5iEsTaBPKNbmo1CdjHzBZfhWGQKAmA7/FCn5Crp/4bHhlaz37Mtis2D2YdXeXR3N2W8aEUf3ae8MhWvcKJPLuybkEGvo7+Qbji/nSxKYLu95BJt7vkNYMIQ1UuWtd6K9bONDllP2WKs8kfy09n8aXLdVPTIG2D7HMizE/V5S
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5577a620-cb26-4e5b-a5fe-08d7f330ab87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2020 09:17:45.8914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1klBB2NLLyaKdejhazP21BCE0ON3ApVGMXD18j0xB8YqzP261pzrHoQsgF3XS7y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
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
Cc: alexander.deucher@amd.com, nirmoy.das@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDUuMjAgdW0gMTA6NDggc2NocmllYiBOaXJtb3kgRGFzOgo+IENyZWF0ZSBzeXNmcyBm
aWxlIHVzaW5nIGF0dHJpYnV0ZXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJtb3kgRGFzIDxuaXJt
b3kuZGFzQGFtZC5jb20+Cj4gUmV2aWV3ZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRl
dWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4u
a29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2RldmljZS5jIHwgMzYgKysrKysrKystLS0tLS0tLS0tLS0tLQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDEyIGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2UuYwo+IGluZGV4IGJmMzAyYzc5OTgzMi4uY2M0MWU4
ZjVhZDE0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9k
ZXZpY2UuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9kZXZpY2Uu
Ywo+IEBAIC0yOTE4LDYgKzI5MTgsMTQgQEAgc3RhdGljIGludCBhbWRncHVfZGV2aWNlX2dldF9q
b2JfdGltZW91dF9zZXR0aW5ncyhzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPiAgIAlyZXR1
cm4gcmV0Owo+ICAgfQo+ICAgCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgYXR0cmlidXRlICphbWRn
cHVfZGV2X2F0dHJpYnV0ZXNbXSA9IHsKPiArCSZkZXZfYXR0cl9wcm9kdWN0X25hbWUuYXR0ciwK
PiArCSZkZXZfYXR0cl9wcm9kdWN0X251bWJlci5hdHRyLAo+ICsJJmRldl9hdHRyX3NlcmlhbF9u
dW1iZXIuYXR0ciwKPiArCSZkZXZfYXR0cl9wY2llX3JlcGxheV9jb3VudC5hdHRyLAo+ICsJTlVM
TAo+ICt9Owo+ICsKPiAgIC8qKgo+ICAgICogYW1kZ3B1X2RldmljZV9pbml0IC0gaW5pdGlhbGl6
ZSB0aGUgZHJpdmVyCj4gICAgKgo+IEBAIC0zMjY3LDI3ICszMjc1LDkgQEAgaW50IGFtZGdwdV9k
ZXZpY2VfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKPiAgIAlxdWV1ZV9kZWxheWVk
X3dvcmsoc3lzdGVtX3dxLCAmYWRldi0+ZGVsYXllZF9pbml0X3dvcmssCj4gICAJCQkgICBtc2Vj
c190b19qaWZmaWVzKEFNREdQVV9SRVNVTUVfTVMpKTsKPiAgIAo+IC0JciA9IGRldmljZV9jcmVh
dGVfZmlsZShhZGV2LT5kZXYsICZkZXZfYXR0cl9wY2llX3JlcGxheV9jb3VudCk7Cj4gLQlpZiAo
cikgewo+IC0JCWRldl9lcnIoYWRldi0+ZGV2LCAiQ291bGQgbm90IGNyZWF0ZSBwY2llX3JlcGxh
eV9jb3VudCIpOwo+IC0JCXJldHVybiByOwo+IC0JfQo+IC0KPiAtCXIgPSBkZXZpY2VfY3JlYXRl
X2ZpbGUoYWRldi0+ZGV2LCAmZGV2X2F0dHJfcHJvZHVjdF9uYW1lKTsKPiArCXIgPSBzeXNmc19j
cmVhdGVfZmlsZXMoJmFkZXYtPmRldi0+a29iaiwgYW1kZ3B1X2Rldl9hdHRyaWJ1dGVzKTsKPiAg
IAlpZiAocikgewo+IC0JCWRldl9lcnIoYWRldi0+ZGV2LCAiQ291bGQgbm90IGNyZWF0ZSBwcm9k
dWN0X25hbWUiKTsKPiAtCQlyZXR1cm4gcjsKPiAtCX0KPiAtCj4gLQlyID0gZGV2aWNlX2NyZWF0
ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX3Byb2R1Y3RfbnVtYmVyKTsKPiAtCWlmIChyKSB7
Cj4gLQkJZGV2X2VycihhZGV2LT5kZXYsICJDb3VsZCBub3QgY3JlYXRlIHByb2R1Y3RfbnVtYmVy
Iik7Cj4gLQkJcmV0dXJuIHI7Cj4gLQl9Cj4gLQo+IC0JciA9IGRldmljZV9jcmVhdGVfZmlsZShh
ZGV2LT5kZXYsICZkZXZfYXR0cl9zZXJpYWxfbnVtYmVyKTsKPiAtCWlmIChyKSB7Cj4gLQkJZGV2
X2VycihhZGV2LT5kZXYsICJDb3VsZCBub3QgY3JlYXRlIHNlcmlhbF9udW1iZXIiKTsKPiArCQlk
ZXZfZXJyKGFkZXYtPmRldiwgIkNvdWxkIG5vdCBjcmVhdGUgYW1kZ3B1IGRldmljZSBhdHRyXG4i
KTsKPiAgIAkJcmV0dXJuIHI7Cj4gICAJfQo+ICAgCj4gQEAgLTMzNzAsMTIgKzMzNjAsMTAgQEAg
dm9pZCBhbWRncHVfZGV2aWNlX2Zpbmkoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCj4gICAJ
YWRldi0+cm1taW8gPSBOVUxMOwo+ICAgCWFtZGdwdV9kZXZpY2VfZG9vcmJlbGxfZmluaShhZGV2
KTsKPiAgIAo+IC0JZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRldiwgJmRldl9hdHRyX3BjaWVf
cmVwbGF5X2NvdW50KTsKPiAgIAlpZiAoYWRldi0+dWNvZGVfc3lzZnNfZW4pCj4gICAJCWFtZGdw
dV91Y29kZV9zeXNmc19maW5pKGFkZXYpOwo+IC0JZGV2aWNlX3JlbW92ZV9maWxlKGFkZXYtPmRl
diwgJmRldl9hdHRyX3Byb2R1Y3RfbmFtZSk7Cj4gLQlkZXZpY2VfcmVtb3ZlX2ZpbGUoYWRldi0+
ZGV2LCAmZGV2X2F0dHJfcHJvZHVjdF9udW1iZXIpOwo+IC0JZGV2aWNlX3JlbW92ZV9maWxlKGFk
ZXYtPmRldiwgJmRldl9hdHRyX3NlcmlhbF9udW1iZXIpOwo+ICsKPiArCXN5c2ZzX3JlbW92ZV9m
aWxlcygmYWRldi0+ZGV2LT5rb2JqLCBhbWRncHVfZGV2X2F0dHJpYnV0ZXMpOwo+ICAgCWlmIChJ
U19FTkFCTEVEKENPTkZJR19QRVJGX0VWRU5UUykpCj4gICAJCWFtZGdwdV9wbXVfZmluaShhZGV2
KTsKPiAgIAlpZiAoYW1kZ3B1X2Rpc2NvdmVyeSAmJiBhZGV2LT5hc2ljX3R5cGUgPj0gQ0hJUF9O
QVZJMTApCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK

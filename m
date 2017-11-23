From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Subject: Re: Kernel crash/Null pointer dereference on vblank
Date: Thu, 23 Nov 2017 18:07:22 +0800
Message-ID: <56b938ac-4597-a354-0f4a-0c2625b10c5a@amd.com>
References: <1228839336.50367.1511334398694@mailxchange.de>
 <20171122150721.GA3192@probook> <20171122223125.GA28038@probook>
 <58b24f03-b71b-4208-4cb7-4706ba947dea@amd.com>
 <20171123083135.GA3320@probook>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------3A0ABDFAEB5E3EA502017BE0"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171123083135.GA3320@probook>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Johannes Hirte <johannes.hirte-rSzmJuYucINa7YElYzY8/Q@public.gmane.org>
Cc: Martin Babutzka <martin.babutzka-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

--------------3A0ABDFAEB5E3EA502017BE0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit

See the attached email, they fixed same issue, each of them is ok to fix 
your issue, your calltrace is  same as the second.

We should already push the first patch in early time, could you check if 
the first patch is in your branch?

Regards,

David Zhou


On 2017年11月23日 16:31, Johannes Hirte wrote:
> On 2017 Nov 23, Chunming Zhou wrote:
>> Which driver are you using?
>>
>> I guess your driver is a bit old, the issue should be fixed before.
>>
> This was with git master from Linus. But even with the latest changes
> from agd5f/drm-next-4.15 both use-after-free still persist. If there are
> fixes for this, they're not available for upstream.
>


--------------3A0ABDFAEB5E3EA502017BE0
Content-Type: message/rfc822; name="Re: [PATCH 1_3] drm_amdgpu: Avoid
 accessing job->entity after the job is scheduled..eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="Re: [PATCH 1_3] drm_amdgpu: Avoid accessing job->entity afte";
	filename*1="r the job is scheduled..eml"

Received: from CY4PR1201MB0199.namprd12.prod.outlook.com (10.172.78.144) by
 MWHPR1201MB0206.namprd12.prod.outlook.com (10.174.99.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4 via Mailbox Transport; Mon, 23 Oct 2017 12:36:53 +0000
Received: from BN6PR12MB1569.namprd12.prod.outlook.com (10.172.18.18) by
 CY4PR1201MB0199.namprd12.prod.outlook.com (10.172.78.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4; Mon, 23 Oct 2017 12:36:53 +0000
Received: from CY4PR12CA0040.namprd12.prod.outlook.com (10.175.82.154) by
 BN6PR12MB1569.namprd12.prod.outlook.com (10.172.18.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4; Mon, 23 Oct 2017 12:36:51 +0000
Received: from CO1NAM03FT057.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e48::205) by CY4PR12CA0040.outlook.office365.com
 (2603:10b6:903:129::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.156.4 via Frontend
 Transport; Mon, 23 Oct 2017 12:36:50 +0000
Authentication-Results: spf=none (sender IP is 131.252.210.177)
 smtp.mailfrom=lists.freedesktop.org; amd.com; dkim=fail (signature did not
 verify) header.d=gmail.com;amd.com; dmarc=fail action=none
 header.from=gmail.com;
Received-SPF: None (protection.outlook.com: lists.freedesktop.org does not
 designate permitted sender hosts)
Received: from gabe.freedesktop.org (131.252.210.177) by
 CO1NAM03FT057.mail.protection.outlook.com (10.152.81.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.178.5 via Frontend Transport; Mon, 23 Oct 2017 12:36:37 +0000
Received: from gabe.freedesktop.org (localhost [127.0.0.1])	by
 gabe.freedesktop.org (Postfix) with ESMTP id 8D68F6E392;	Mon, 23 Oct 2017
 12:36:36 +0000 (UTC)
X-Original-To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Delivered-To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Received: from mail-wm0-x243.google.com (mail-wm0-x243.google.com
 [IPv6:2a00:1450:400c:c09::243]) by gabe.freedesktop.org (Postfix) with ESMTPS
 id C1F436E392 for <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Mon, 23 Oct 2017 12:36:34
 +0000 (UTC)
Received: by mail-wm0-x243.google.com with SMTP id b9so3800058wmh.0 for
 <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Mon, 23 Oct 2017 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=lttPlJDjtuyff+kXnu4MKHvSvf7hUUFBqH6sj+nSHZ8=;
 b=dZ+YMkLHBd5FB6UqZKJX1GyCWvVJjBVUAppJdbTFiFQlW8Tfl9D7EAXslfXjbJ2Ne5
 eFny4ksSYJ5C4wcDv1IdFtjByT/zdXG+8vXQqXydNRctsVxZQqcYq35f0VAjsCjNSn0j
 HRY93g/+OdmVnzff6tFr2fvTk7cwb6O6YQ3Q11iVxIciqhhV1ebQJw6FGY/8hyHoH98B
 g7pYKLYwt126um2GuwhSWW+mOyQhwBPm69mbk3WYQpEGYJU+B3qFceTceh9iXOBWvTia
 6W5pWOTuOKliRNRJupTY5d0svm01uEqmcGFD61IQM7JUEiJiINEGN6TntwFfxUlyZ1gp
 4V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=lttPlJDjtuyff+kXnu4MKHvSvf7hUUFBqH6sj+nSHZ8=;
 b=PtcG7+NszpDHIwECg8YI2UeZyMcprvI5oOYJ//zYp/UV02N7uuB5aDlttsVNWppPgg
 BMnH8nIHMKUB8hZxkyqv0l/pn5CYcqgJa4u+tl9I938+l8m90Q3vCAR70ims7thBA+Ws
 j7lnk10mOA8HvYhHSfj/FOZQkd6ODMaS0+RnSTRrsQ6Fn++sYOdFZCuG7dyydl4aDXu4
 qjkFipW2xuXwn0i9vZhHgJCLsKKm+El7sYvu6fIOfcW++mHFnqCVJ1fwGugq/n6/4hdF
 /+h5RPA57aez4qOGGPaQfZBcBfmlyjcjDlWxXMNE4EHuH2+i0oVYg0S2O8Qey28sz7Mz
 Fx0Q==
X-Gm-Message-State: AMCzsaXrjZ91y85A0k//0WuOpWeESy2kvekm2VCDtW12D/U1HrW6Joff
 ELLxTsi6mRQegRdLDx7SJuZHKgmo
X-Google-Smtp-Source: ABhQp+Rb92vGWjKETfCe0+JnmWzOABBP+fYYpIxBmKlHO6fwEq1/R1aJ1VGsP4qpbUMcccmfRnINNg==
X-Received: by 10.28.93.200 with SMTP id r191mr5713589wmb.19.1508762193329;
 Mon, 23 Oct 2017 05:36:33 -0700 (PDT)
Received: from ?IPv6:2a02:908:1251:7981:acb0:93ce:803c:840?
 ([2a02:908:1251:7981:acb0:93ce:803c:840]) by smtp.gmail.com with ESMTPSA id
 x189sm3187915wmf.10.2017.10.23.05.36.32 (version=TLS1_2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128); Mon, 23 Oct 2017 05:36:32
 -0700 (PDT)
Subject: Re: [PATCH 1/3] drm/amdgpu: Avoid accessing job->entity after the job
 is scheduled.
To: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>,
	<amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
References: <1508506327-1084-1-git-send-email-Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Message-ID: <6b49f609-a083-ddde-ff3b-2abfe39890c3-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Mon, 23 Oct 2017 14:36:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
In-Reply-To: <1508506327-1084-1-git-send-email-Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Content-Language: en-US
CC: <christian.koenig-5C7GfCeVMHo@public.gmane.org>
X-BeenThere: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
X-Mailman-Version: 2.1.18
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Reply-To: <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; format=flowed
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Return-Path: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
X-MS-Exchange-Organization-Network-Message-Id: 5930eefd-1bf7-432f-5fe7-08d51a12bbdf
X-EOPAttributedMessage: 0
X-EOPTenantAttributedMessage: 3dd8961f-e488-4e60-8e11-a82d994e183d:0
X-MS-Exchange-Organization-MessageDirectionality: Incoming
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.252.210.177;IPV:NLI;CTRY:US;EFV:NLI;SFV:SKN;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:BN6PR12MB1569;H:gabe.freedesktop.org;FPR:;SPF:None;LANG:en;;SKIP:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM03FT057;1:hnNBHT2XCLE/2sB6uRajWQYwRbNAERxxdnfOeoRkFvEqln9aAiTltD4Nn6xsXo6KF2eK0Is8dEY2cKKvT8mbAm7U/61NkSOAgmslxwKHOuYuiYpuFQ2Fk6lhuyu43vDX
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5930eefd-1bf7-432f-5fe7-08d51a12bbdf
X-DkimResult-Test: Failed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(23075)(22001)(3002016)(4534020)(3010002)(71702078);SRVR:BN6PR12MB1569;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1569;3:8O5KY+Y6ZjxVd6YQjnGyp5c1DeRGQbeIkx+qvfFxMfAqvG7Dq2U0utsdplCVn/ehFEg/Y6BrHVYk3aXbi1M23VdUNKKzWvf14806Fg7Ur6yRkKDCy6sJKlDTwBP6KzqO5cewKJscuoW600mVmmuHVQZ1T3lWkHNBNW0NyGPdpLbXnK9YYLqAkDhK7UXf6fEQ+M0xo9uGYFrW+KEYWU8UoZyiQtmLelqbGPYapN0aao7slIvelx0g2KhJ1c8tc/VNqRetJXu8oNRye5w0B06PGaFBg+iEIICesWNh7F/DXj/766vh2t/kc/NtZ+XAj9kbBcOGL9UFCEQL5QLo6HMLDeHnEqaC5oD+22L4YI1F9d8=;25:Mj41/lP8ooENG/5l/GDStUOh+3pVLKiXguHTADFHvxGiFvbRYV9Xj3ksAKKob8Mm9XMdhtIgCoyJAmY94bVOd/aVaMQBzjO8owg/TVBT/hfVxXbV0l5ztZzYhoHT0RlzBBjX4WEmbyhcZfQTk7rlmc5x9Ir+y4QjUUmQY07uvslKoL1S4S0+EXi1TCnL3+MMN6qWp2cxTeReXWOPGsuWEUKyizdogNyqfS9K7n9NGnjq4VhhuUGWGnBP8mjX07mG6WXlebVufbroqIzRHnzyJKmOTXAFqULA1M4iPX7CJadS8cPGaVG7daJuDO/qTQdW9KKro1ArpYCbC2XUh9g9n8njmzkO0GOOO2UGWgLYuA8=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1569:|CY4PR1201MB0199:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1569;31:JP77uVriTktQBL6N5Bn2yKb7pAq2kWS3jPM47RKI2uowX2PCwzml1OnDViJZkSETc75yG7VsSpDmI44gp8ECwn/RLL7K/7AksccwCnT9n85QcxbQYfOZ/FEr7VDf12sMARTK6+pIM51riyjaVDolDFdrqMmkklet5Dk2FBGjgh5aTLRx9iONOT4DNIzOsDQ1FEkhmp1rn+ygvcOpRKwgX3ORmLubeSCVaPmHY5UR4rs=;20:TLieWAmRVMiMja676UN0mw2fF1tRnsfxtw/P/ECEukCdOd4rOyeYEv40q92k0Gm6R60ABLquaBUKKnHzBlM7qCtFrsXPcYJu8NAKf0Oz+7SAzguQQfm1z5jvao2Uoo+OKGg7YeTtqeZdfPvY8chDmKG5BPdKro4NLQ0L80z16AQLQqFCDSSAaAwG70ujhzQa1OiW9fEZ+IlEB7Ma05BYICKNAMfkCS8xAHWGC/vo7ItkrADtjP+jHJEhw8Fy/VWCx/iiURFKt6l8kZIl3DwI8vpBaIPxiObnv8p3jcI1XzhnFSOI0R7UGXhKDmMr+TGrR5vM4p2KzzdTWYtQTEfvkxPenIbqdbYvn8HB0r++osCDqGVF/y5ozuJ2q/i3uiLo8ABx1rZPPeT3RBZoOLdRpSiJQcB/TT8U7wzB8i4VwO7czxXFnTpIh3k8odYhDmGJALb6v+FmV/4yKuGxIQE1rQbzuz1RjUyc7RjOtB5j/qrnd8qlMEOXIw6HC2L
 LceJgFKj6bcphuuHOpGEP66cn/jRHqawUMEfebnbzBeQaPXUXI4TTZ7LgAx6wWAmWqRYbL0x+37QbHsQEU8Mi/ixQJKCu9j0/pTQqmtRT4rBpWOc=
X-MS-Exchange-Organization-SCL: -1
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(2401047)(8121501046)(9101536074)(10201501046)(3002001)(100000703101)(100105400095)(93006095)(93000095)(12181506113)(3231020)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:BN6PR12MB1569;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:BN6PR12MB1569;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1569;4:kfs/CMRY9naKXf0Ibp+5PIhGC9XC/anGuSMWg0WBvt5ok5AWHKwnGoMxLvNNfJdRHdrGnYxBhIPcgzuPRBRz7kMr2W+hpONJ458PgBEXw0IYmDVELEXZGmTPwvEl2IvptUR585wsUCPT5lmZCxt0RTcjxAgDlyu+lVthk4GLyNNjPG6ClYBrBE0zr0npVqeLHy/sMYYxkCkzX1xsFAWm8x//f+gyj2RHnCm0EJAkwAFMVPI/24Th6DfbiozlIaMwdh9OnoogR+j3zCTt0Z/FFhHDcAKYMlWvj76V4C8Wib8MFSBQcG8eGuh0yvUgICWOGBJgTVPtC2IoPq90Qu7b2X/YdN7VjM8++elu1e/m5Yk=;23:NUWWVDhtZPbSTLsh1NKKkNYjDZHE1h7gRmQcgTzjVkm9MqmhscWg5vIVNZLgbdBLNbtmeVND3rAkRmf6fJZumxI2hA4vPgZyidZtBJwO6uiZ625627LVNxivo/6FwZ+miw85opBh28udwJihlM6aP0nwHCFOTkbvtsVP8CHbflyLjY2fhT9flZ/Lm5QcgVxL;6:uEEscIQsikm73c7v4Qul5+Vv0+pTpGisdpGTIPDqZGbfizLXJ9HzELS2rhIbhy5udmK779OrSToMghYC2vjZOgHDi/qdy/3KUe057o3zLZL5W1ovemDjYT+5lU9V7eF9lMiIt2UcZ723E2x3VQ1IAM3Kx1RjKrYMJy5xbztlTep4Gl+HyyatjANbt
 G4T2u5Hy0LcpAshGoBPENnkp3DoVMbO/2wU8DKLaOhYt2fCPXQLrV5EL6TSThxrbiTLw8+yRLxSYgbXg0My3+DvfDKrImG1Ucdk+VTFGI/m+dmS5+94Avht7hdC2Le7Pr71N39yfFCJAhzVwBYELHxhdp3j1g==
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1569;5:e9pDnIKMdoLXxn8JBKqHwh6+PCg+A6fymssevfyNzmBX8V3LpSYzpTaXBtEQDy53ffFRPyPJbnP3COZfYLlIJvjPEfWt6N3KBXgA1aEPQeLbQcT2FEdZi3ob7/ih9hpmp45QwzA2HwGlWPpJ+iYlaA==;24:Vp1/rDzWjWV7Qct3wXrvKCpkOrw+LJsoGN/Izxrxv8fsLVA87Dk1rp7ACR2dqTBv3L2qKB68GTnpRrBg/hNysDJVJ9p3qAMKS6UpqydkRrI=;7:7gVVrrJLNUvX31J9ewaWEJluEcRQGDmQ63rs7zFWkagwjmO4H4VFyYffp6VifErXQhg13ntqfWPaxg/j5cAGP7/x6vFaZcen3UO+OMx83L4Tmbf+xlfQF67S7aWVebrZsSCqwEvhguxjrfYGnpXPePmFJj5+tATzNWYoHg+jzDw5ol0hGW8UmZC97yZOoRZOPK+FP3XHcq8wfJeTb0/WuSPfbcXwxtr9NeACiHKDIT4=;20:1AO5UxPLKMbmDfXf032LWpRF7i7nSp8WcNvRyoi7WmO04dzV0e40uxgdDKDxRoyOASLljgLnpEtYmrUuUwdKRGvTSRg4HE9LU2b0GhDkT44b+k1XDBcPmJYJR799EuI+IKu8hxTzRPH6bSyxh/yF3CFTqEJZcE9DOe3q1CNUP8b+fYErLtEZxTAoqmOqvJvauObQ/qKMW1BCZ851KD5sqHVATUdVQ+AI1ay43gzRy3oos9+g8
 Cm3gsp8SC5JUm3W
SpamDiagnosticOutput: 1:2
SpamDiagnosticMetadata: a13811e2228e4014ba0cf06b473c0502
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2017 12:36:37.4586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5930eefd-1bf7-432f-5fe7-08d51a12bbdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1569
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0199;23:yHmro/A2g5UttuMCfU3EzaS/8WaAfjsh7xpoKhxkBNIyelW78SnqBQOx111/DnAU1hcwMJWvj9J3sxnP17B+ZALjgXs5xPu4xqqBVswT5BRFQlCmUL3syr0lq32Lsc0T5P57rGUvGyPGQfsmJwTYEY4kXT8/PM4EfofvyMUv0sW6nb5xw4siLRG1Kx32WMcY
X-MS-Exchange-Organization-AuthSource: CO1NAM03FT057.eop-NAM03.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Transport-EndToEndLatency: 00:00:16.5880318
X-MS-Exchange-Processed-By-BccFoldering: 15.20.0156.006
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0206;27:4rshBdfqYPFqSsXHWiySE6iWDHaqEr//AWs2JIHF/JuzuCAwrbyuPj3mDSB9j6e/paPQPF48SBWGsVtP6gpgNVTny6/nvAVkopHtuSrs58XLw+HoKJFo89Ss47INd5GQ
MIME-Version: 1.0

QW0gMjAuMTAuMjAxNyB1bSAxNTozMiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+IEJ1Zzog
YW1kZ3B1X2pvYl9mcmVlX2NiIHdhcyBhY2Nlc3Npbmcgc19qb2ItPnNfZW50aXR5IHdoZW4gdGhl
IGFsbG9jYXRlZAo+IGFtZGdwdV9jdHggKGFuZCB0aGUgZW50aXR5IGluc2lkZSBpdCkgd2VyZSBh
bHJlYWR5IGRlYWxsb2NhdGVkIGZyb20KPiBhbWRncHVfY3NfcGFyc2VyX2ZpbmkuCj4KPiBGaXg6
IFNhdmUgam9iJ3MgcHJpb3JpdHkgb24gaXQncyBjcmVhdGlvbiBpbnN0ZWFkIG9mIGFjY2Vzc2lu
ZyBpdCBmcm9tCj4gc19lbnRpdHkgbGF0ZXIgb24uCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXkg
R3JvZHpvdnNreSA8QW5kcmV5Lkdyb2R6b3Zza3lAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cgo+IC0tLQo+ICAgZHJpdmVy
cy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgICAgICAgIHwgIDMgKy0tCj4gICBkcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfam9iLmMgICAgICAgfCAgNSArKy0tLQo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jIHwgIDEgKwo+ICAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5oIHwgMzIgKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tCj4gICA0IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDIzIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9jcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Nz
LmMKPiBpbmRleCBmN2ZjZWI2Li5hNzYwYjZlIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2NzLmMKPiBAQCAtMTE5Miw4ICsxMTkyLDcgQEAgc3RhdGljIGludCBhbWRncHVf
Y3Nfc3VibWl0KHN0cnVjdCBhbWRncHVfY3NfcGFyc2VyICpwLAo+ICAgCWpvYi0+dWZfc2VxdWVu
Y2UgPSBzZXE7Cj4gICAKPiAgIAlhbWRncHVfam9iX2ZyZWVfcmVzb3VyY2VzKGpvYik7Cj4gLQlh
bWRncHVfcmluZ19wcmlvcml0eV9nZXQoam9iLT5yaW5nLAo+IC0JCQkJIGFtZF9zY2hlZF9nZXRf
am9iX3ByaW9yaXR5KCZqb2ItPmJhc2UpKTsKPiArCWFtZGdwdV9yaW5nX3ByaW9yaXR5X2dldChq
b2ItPnJpbmcsIGpvYi0+YmFzZS5zX3ByaW9yaXR5KTsKPiAgIAo+ICAgCXRyYWNlX2FtZGdwdV9j
c19pb2N0bChqb2IpOwo+ICAgCWFtZF9zY2hlZF9lbnRpdHlfcHVzaF9qb2IoJmpvYi0+YmFzZSk7
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9qb2IuYwo+IGluZGV4IDBjZmM2OGQu
LmE1OGUzYzUgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1
X2pvYi5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2pvYi5jCj4g
QEAgLTEwNCw3ICsxMDQsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfam9iX2ZyZWVfY2Ioc3RydWN0
IGFtZF9zY2hlZF9qb2IgKnNfam9iKQo+ICAgewo+ICAgCXN0cnVjdCBhbWRncHVfam9iICpqb2Ig
PSBjb250YWluZXJfb2Yoc19qb2IsIHN0cnVjdCBhbWRncHVfam9iLCBiYXNlKTsKPiAgIAo+IC0J
YW1kZ3B1X3JpbmdfcHJpb3JpdHlfcHV0KGpvYi0+cmluZywgYW1kX3NjaGVkX2dldF9qb2JfcHJp
b3JpdHkoc19qb2IpKTsKPiArCWFtZGdwdV9yaW5nX3ByaW9yaXR5X3B1dChqb2ItPnJpbmcsIHNf
am9iLT5zX3ByaW9yaXR5KTsKPiAgIAlkbWFfZmVuY2VfcHV0KGpvYi0+ZmVuY2UpOwo+ICAgCWFt
ZGdwdV9zeW5jX2ZyZWUoJmpvYi0+c3luYyk7Cj4gICAJYW1kZ3B1X3N5bmNfZnJlZSgmam9iLT5k
ZXBfc3luYyk7Cj4gQEAgLTE0MSw4ICsxNDEsNyBAQCBpbnQgYW1kZ3B1X2pvYl9zdWJtaXQoc3Ry
dWN0IGFtZGdwdV9qb2IgKmpvYiwgc3RydWN0IGFtZGdwdV9yaW5nICpyaW5nLAo+ICAgCWpvYi0+
ZmVuY2VfY3R4ID0gZW50aXR5LT5mZW5jZV9jb250ZXh0Owo+ICAgCSpmID0gZG1hX2ZlbmNlX2dl
dCgmam9iLT5iYXNlLnNfZmVuY2UtPmZpbmlzaGVkKTsKPiAgIAlhbWRncHVfam9iX2ZyZWVfcmVz
b3VyY2VzKGpvYik7Cj4gLQlhbWRncHVfcmluZ19wcmlvcml0eV9nZXQoam9iLT5yaW5nLAo+IC0J
CQkJIGFtZF9zY2hlZF9nZXRfam9iX3ByaW9yaXR5KCZqb2ItPmJhc2UpKTsKPiArCWFtZGdwdV9y
aW5nX3ByaW9yaXR5X2dldChqb2ItPnJpbmcsIGpvYi0+YmFzZS5zX3ByaW9yaXR5KTsKPiAgIAlh
bWRfc2NoZWRfZW50aXR5X3B1c2hfam9iKCZqb2ItPmJhc2UpOwo+ICAgCj4gICAJcmV0dXJuIDA7
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVs
ZXIuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwo+IGlu
ZGV4IGU0ZDNiNGUuLjFiYmJjZTIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9z
Y2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hl
ZHVsZXIvZ3B1X3NjaGVkdWxlci5jCj4gQEAgLTUyOSw2ICs1MjksNyBAQCBpbnQgYW1kX3NjaGVk
X2pvYl9pbml0KHN0cnVjdCBhbWRfc2NoZWRfam9iICpqb2IsCj4gICB7Cj4gICAJam9iLT5zY2hl
ZCA9IHNjaGVkOwo+ICAgCWpvYi0+c19lbnRpdHkgPSBlbnRpdHk7Cj4gKwlqb2ItPnNfcHJpb3Jp
dHkgPSBlbnRpdHktPnJxIC0gc2NoZWQtPnNjaGVkX3JxOwo+ICAgCWpvYi0+c19mZW5jZSA9IGFt
ZF9zY2hlZF9mZW5jZV9jcmVhdGUoZW50aXR5LCBvd25lcik7Cj4gICAJaWYgKCFqb2ItPnNfZmVu
Y2UpCj4gICAJCXJldHVybiAtRU5PTUVNOwo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmggYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVk
dWxlci9ncHVfc2NoZWR1bGVyLmgKPiBpbmRleCA1MmM4ZTU0Li4zZjc1YjQ1IDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuaAo+ICsrKyBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuaAo+IEBAIC0zMCw2
ICszMCwxOSBAQAo+ICAgc3RydWN0IGFtZF9ncHVfc2NoZWR1bGVyOwo+ICAgc3RydWN0IGFtZF9z
Y2hlZF9ycTsKPiAgIAo+ICtlbnVtIGFtZF9zY2hlZF9wcmlvcml0eSB7Cj4gKwlBTURfU0NIRURf
UFJJT1JJVFlfTUlOLAo+ICsJQU1EX1NDSEVEX1BSSU9SSVRZX0xPVyA9IEFNRF9TQ0hFRF9QUklP
UklUWV9NSU4sCj4gKwlBTURfU0NIRURfUFJJT1JJVFlfTk9STUFMLAo+ICsJQU1EX1NDSEVEX1BS
SU9SSVRZX0hJR0hfU1csCj4gKwlBTURfU0NIRURfUFJJT1JJVFlfSElHSF9IVywKPiArCUFNRF9T
Q0hFRF9QUklPUklUWV9LRVJORUwsCj4gKwlBTURfU0NIRURfUFJJT1JJVFlfTUFYLAo+ICsJQU1E
X1NDSEVEX1BSSU9SSVRZX0lOVkFMSUQgPSAtMSwKPiArCUFNRF9TQ0hFRF9QUklPUklUWV9VTlNF
VCA9IC0yCj4gK307Cj4gKwo+ICsKPiAgIC8qKgo+ICAgICogQSBzY2hlZHVsZXIgZW50aXR5IGlz
IGEgd3JhcHBlciBhcm91bmQgYSBqb2IgcXVldWUgb3IgYSBncm91cAo+ICAgICogb2Ygb3RoZXIg
ZW50aXRpZXMuIEVudGl0aWVzIHRha2UgdHVybnMgZW1pdHRpbmcgam9icyBmcm9tIHRoZWlyCj4g
QEAgLTgzLDYgKzk2LDcgQEAgc3RydWN0IGFtZF9zY2hlZF9qb2Igewo+ICAgCXN0cnVjdCBkZWxh
eWVkX3dvcmsJCXdvcmtfdGRyOwo+ICAgCXVpbnQ2NF90CQkJaWQ7Cj4gICAJYXRvbWljX3Qga2Fy
bWE7Cj4gKwllbnVtIGFtZF9zY2hlZF9wcmlvcml0eSBzX3ByaW9yaXR5Owo+ICAgfTsKPiAgIAo+
ICAgZXh0ZXJuIGNvbnN0IHN0cnVjdCBkbWFfZmVuY2Vfb3BzIGFtZF9zY2hlZF9mZW5jZV9vcHNf
c2NoZWR1bGVkOwo+IEBAIC0xMTQsMTggKzEyOCw2IEBAIHN0cnVjdCBhbWRfc2NoZWRfYmFja2Vu
ZF9vcHMgewo+ICAgCXZvaWQgKCpmcmVlX2pvYikoc3RydWN0IGFtZF9zY2hlZF9qb2IgKnNjaGVk
X2pvYik7Cj4gICB9Owo+ICAgCj4gLWVudW0gYW1kX3NjaGVkX3ByaW9yaXR5IHsKPiAtCUFNRF9T
Q0hFRF9QUklPUklUWV9NSU4sCj4gLQlBTURfU0NIRURfUFJJT1JJVFlfTE9XID0gQU1EX1NDSEVE
X1BSSU9SSVRZX01JTiwKPiAtCUFNRF9TQ0hFRF9QUklPUklUWV9OT1JNQUwsCj4gLQlBTURfU0NI
RURfUFJJT1JJVFlfSElHSF9TVywKPiAtCUFNRF9TQ0hFRF9QUklPUklUWV9ISUdIX0hXLAo+IC0J
QU1EX1NDSEVEX1BSSU9SSVRZX0tFUk5FTCwKPiAtCUFNRF9TQ0hFRF9QUklPUklUWV9NQVgsCj4g
LQlBTURfU0NIRURfUFJJT1JJVFlfSU5WQUxJRCA9IC0xLAo+IC0JQU1EX1NDSEVEX1BSSU9SSVRZ
X1VOU0VUID0gLTIKPiAtfTsKPiAtCj4gICAvKioKPiAgICAqIE9uZSBzY2hlZHVsZXIgaXMgaW1w
bGVtZW50ZWQgZm9yIGVhY2ggaGFyZHdhcmUgcmluZwo+ICAgKi8KPiBAQCAtMTc2LDEwICsxNzgs
NCBAQCBib29sIGFtZF9zY2hlZF9kZXBlbmRlbmN5X29wdGltaXplZChzdHJ1Y3QgZG1hX2ZlbmNl
KiBmZW5jZSwKPiAgIAkJCQkgICAgc3RydWN0IGFtZF9zY2hlZF9lbnRpdHkgKmVudGl0eSk7Cj4g
ICB2b2lkIGFtZF9zY2hlZF9qb2Jfa2lja291dChzdHJ1Y3QgYW1kX3NjaGVkX2pvYiAqc19qb2Ip
Owo+ICAgCj4gLXN0YXRpYyBpbmxpbmUgZW51bSBhbWRfc2NoZWRfcHJpb3JpdHkKPiAtYW1kX3Nj
aGVkX2dldF9qb2JfcHJpb3JpdHkoc3RydWN0IGFtZF9zY2hlZF9qb2IgKmpvYikKPiAtewo+IC0J
cmV0dXJuIChqb2ItPnNfZW50aXR5LT5ycSAtIGpvYi0+c2NoZWQtPnNjaGVkX3JxKTsKPiAtfQo+
IC0KPiAgICNlbmRpZgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
Cmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=

--------------3A0ABDFAEB5E3EA502017BE0
Content-Type: message/rfc822; name="Re: [PATCH] drm_amd_scheduler: fix one
 used-after-free case for job->s_entity.eml"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="Re: [PATCH] drm_amd_scheduler: fix one used-after-free case ";
	filename*1="for job->s_entity.eml"

Received: from CY4PR1201MB0198.namprd12.prod.outlook.com (10.172.78.143) by
 MWHPR1201MB0206.namprd12.prod.outlook.com (10.174.99.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4 via Mailbox Transport; Tue, 24 Oct 2017 10:10:33 +0000
Received: from CY4PR1201MB2469.namprd12.prod.outlook.com (10.172.116.8) by
 CY4PR1201MB0198.namprd12.prod.outlook.com (10.172.78.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4; Tue, 24 Oct 2017 10:10:32 +0000
Received: from MWHPR1201CA0013.namprd12.prod.outlook.com (10.174.253.23) by
 CY4PR1201MB2469.namprd12.prod.outlook.com (10.172.116.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4; Tue, 24 Oct 2017 10:10:30 +0000
Received: from DM3NAM03FT013.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::203) by MWHPR1201CA0013.outlook.office365.com
 (2603:10b6:301:4a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.178.6 via
 Frontend Transport; Tue, 24 Oct 2017 10:10:30 +0000
Authentication-Results: spf=none (sender IP is 131.252.210.177)
 smtp.mailfrom=lists.freedesktop.org; amd.com; dkim=fail (signature did not
 verify) header.d=amdcloud.onmicrosoft.com;amd.com; dmarc=permerror
 action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: lists.freedesktop.org does not
 designate permitted sender hosts)
Received: from gabe.freedesktop.org (131.252.210.177) by
 DM3NAM03FT013.mail.protection.outlook.com (10.152.82.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.178.5 via Frontend Transport; Tue, 24 Oct 2017 10:10:28 +0000
Received: from gabe.freedesktop.org (localhost [127.0.0.1])	by
 gabe.freedesktop.org (Postfix) with ESMTP id 2534C6E41D;	Tue, 24 Oct 2017
 10:10:27 +0000 (UTC)
X-Original-To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Delivered-To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0063.outbound.protection.outlook.com [104.47.36.63]) by
 gabe.freedesktop.org (Postfix) with ESMTPS id 391B76E41D for
 <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Tue, 24 Oct 2017 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=L5iPPlllNLtK8vbApfbKXKuucI9533GvjVN0pZGy2G4=;
 b=gfOVxSDol2ffL2GPMeuLVX7KeLyZqVxupdnX3+dNjKsKagxtxy+qPqHj90VD3z6fxhuNACT70JdboHIsXilzbhinQtpz6YCWfZ81t7sWnkEeE9dV4w4HsYhk1SSFADJJTan+YWzCtj+1aOJmr2oj0VQaSdeYPxk1uyFISXZ9TXA=
Received: from BN4PR12CA0015.namprd12.prod.outlook.com (10.164.241.25) by
 DM5PR12MB1275.namprd12.prod.outlook.com (10.168.237.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.156.4; Tue, 24 Oct 2017 10:10:24 +0000
Received: from DM3NAM03FT027.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e49::206) by BN4PR12CA0015.outlook.office365.com
 (2603:10b6:403:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.156.4 via
 Frontend Transport; Tue, 24 Oct 2017 10:10:24 +0000
Authentication-Results-Original: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV02.amd.com (165.204.84.17) by
 DM3NAM03FT027.mail.protection.outlook.com (10.152.82.190) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.178.5 via Frontend Transport; Tue, 24 Oct 2017 10:10:23 +0000
Received: from SCYBEXDAG03.amd.com (10.34.11.13) by SATLEXCHOV02.amd.com
 (10.181.40.72) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 24 Oct
 2017 05:10:22 -0500
Received: from [10.237.74.158] (10.237.74.158) by SCYBEXDAG03.amd.com
 (10.34.11.13) with Microsoft SMTP Server (TLS) id 14.3.361.1; Tue, 24 Oct
 2017 18:10:17 +0800
Subject: Re: [PATCH] drm/amd/scheduler: fix one used-after-free case for
 job->s_entity
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian"
	<Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>,
	"amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
References: <1508838949-29379-1-git-send-email-david1.zhou-5C7GfCeVMHo@public.gmane.org>
 <86482ba2-2d7e-a0f0-72ac-d4e99349cbff-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
 <BLUPR12MB0449ACDFEF5C24528B3301B984470-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
From: Chunming Zhou <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Message-ID: <8eaffd53-67eb-251d-440b-fb48df5d39a2-5C7GfCeVMHo@public.gmane.org>
Date: Tue, 24 Oct 2017 18:10:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
In-Reply-To: <BLUPR12MB0449ACDFEF5C24528B3301B984470-7LeqcoF/hwpTIQvHjXdJlwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: en-US
X-Originating-IP: [10.237.74.158]
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report-Untrusted: CIP:165.204.84.17; IPV:NLI; CTRY:US;
 EFV:NLI; SFV:NSPM;
 SFS:(10009020)(6009001)(39860400002)(346002)(376002)(2980300002)(428002)(51234002)(199003)(189002)(13464003)(24454002)(16526018)(65956001)(47776003)(2501003)(101416001)(50466002)(229853002)(68736007)(50986999)(305945005)(77096006)(7736002)(76176999)(54356999)(356003)(189998001)(97736004)(23676002)(8936002)(2906002)(2870700001)(64126003)(81166006)(8676002)(81156014)(6116002)(16576012)(230783001)(72206003)(106466001)(110136005)(3846002)(65806001)(575784001)(478600001)(83506002)(33646002)(2950100002)(58126008)(966005)(316002)(31686004)(65826007)(31696002)(53546010)(6246003)(105586002)(6306002)(5660300001)(36756003)(53936002)(3940600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1275; H:SATLEXCHOV02.amd.com; FPR:;
 SPF:None; PTR:InfoDomainNonexistent; A:1; MX:1; LANG:en;
X-Microsoft-Exchange-Diagnostics-untrusted: 1; DM3NAM03FT027;
 1:Yj1O/4zDnTfv57f1ib/ihGvXT2AmmTNNGn8JGOBabWscHJ1qLUmGTJfRt+PdKW0Rv0P/YnnQh8YlhCkqNmjWbOJUi4/3IqY8lcgCsIBQDIAqtFfWJY/2pbAxWHXWGyJm
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5be1ad3-80ea-442b-a8ea-08d51ac774a8
X-Microsoft-Antispam-Untrusted: UriScan:; BCL:0; PCL:0;
 RULEID:(22001)(4534020)(4602075)(4627075)(201703031133081)(201702281549075)(2017052603199);
 SRVR:DM5PR12MB1275;
X-Microsoft-Exchange-Diagnostics-untrusted: 1; DM5PR12MB1275;
 3:jc+f0jF20YCyQyVhgAk1beLiMrQUbwSXwvTPDJDDWIZqsSy7GwEgCZOnhNv1HC7Tj1myTNOBm711mUjmCC510heZXtpNg8AcBgK8g9HABYN+/+6qklsPdzu4+vucC2D677UZll1HKuJOk+CoTkNsk39jjCksPX9JoeQPs4UM/7YLLd01B6RTkTtPRLv2dmYHl5qtMeXjs9Xc5swKQ+4Nd2XDl0f9DUCkVW7sIOdQMm0dwsZeGII3t4CD0Hn6+KXweICJhPOYawWOhJtIjHS5oVynEH9tQFE+0oKaR8hSa153RL9jPrGv4NxmQe67b+9bq8EfGLuIz1/UGPN/NOfw/xGowVLVQYiEGrOdrdyWyF8=;
 25:XNQNJuKgYmHex2YQbNFs8GvzyvGLzI3QtxvlrKEElQKYixwk3Knd1MrkPVkcNmdieb45cyKz9dPGGZy34XcGxOKHf8XX+4haK0R+PT6WKtHunUre0ZZ1mfItEb/2FeTCz6CDqBxKf3rbOA0ehCgUHwtAmG5YurdVoXs+j2BJWhLuvGr34rNLAR+G37/Z7V9wH5eJu1PG8m/dxzQM+9WH6qqx1PwesxhsG3PFxoCrEA6JYt/PNanDE5H0efsgvsETFrbgUANLv3GLRTvNnKDBkZvgv342gCZ01jxnNZnm1f1PJXQpHHKgmpBvfQHm4yzY6Jcu1MMGlmSbSxCRy25Stw==
X-MS-TrafficTypeDiagnostic: DM5PR12MB1275:|CY4PR1201MB2469:|CY4PR1201MB0198:
X-Microsoft-Exchange-Diagnostics-untrusted: 1; DM5PR12MB1275;
 31:OQzk8EBL+8/6rOuoMmhVrEjlu8/86UUKOZ5sAcx+P8d6VulmdCcazGkluwo2oXzmiJOr9OJcka+OHLEEXsyp9ea6hkIHOj8SG0Bb4QoWMrg0R5/L873+0abbGKkQp/paSoU9tx2HW55zqhaHCBM227P5KlG9n/5jg51apR0gmKyDPoo/oL9aSxlmHZ2wFN1oRxDzbGCOSfanCDglDCUaODuuG4+XWYuD6HbbtgsFmjY=;
 20:6yAtLwabCapqk/+OyzJuQQLXwG89YayGkgy5N85wSQ8VvxyuirJIvDkwYNMCHif6WDW19o459WB8p8+D4enEa466eK1tPzgy47FVejc8/GZlYiZTrmKvIn+tLib7pelwa0XxbztfnvvbBwWaN7U2C2/Rp1Omiu1o/mwf8miH2dULox31n1Lg1ozxSRzIi54MSzNvgiMZaiuutp0fChu+fKldwODt5FrG4MF+1dab1yPvwtEVWaqC1QUr4qTK+ww1HvS838UkSZPAVHPoi97btblW09wD0XFp4l0SfZk+XTJV1GJ+xsjHDOrVInUaZAw4JuFLSVn/YhVzKIUa0NBEmVPDO1/DYTSaf0nRzNxkhueUeyIDiktHLLhLWdToyjA6x/qeyKtojbJlIcB6VlXj4pg/ka/ej1j1CogkTjc+mWXHshOCnCaizR3bTYxvotE7QVXTHeMdjGOIoVgplbXXMW5/FFULqSFTVoagnNfzECJzTaXMYUtXFDvFQhWEEa/G
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240)(17755550239193);
 UriScan:(767451399110)(217544274631240)(17755550239193);
X-Microsoft-Antispam-PRVS: <DM5PR12MB1275AEB0CA6139A1EDFE645DB4470-2J9CzHegvk/BR1eTRs1XOwdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
 RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(6040450)(2401047)(8121501046)(5005006)(93006095)(93003095)(100000703101)(100105400095)(3002001)(10201501046)(3231020)(6055026)(6041248)(20161123562025)(20161123564025)(20161123558100)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123555025)(20161123560025)(6072148)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);
 SRVR:DM5PR12MB1275; BCL:0; PCL:0;
 RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);
 SRVR:DM5PR12MB1275;
 BCL:0;PCL:0;RULEID:(100000700101)(100105000095)(100000701101)(100105300095)(100000702101)(100105100095)(9101522173)(2401047)(8121501046)(9101504095)(9101519026)(9101525026)(9101536074)(93006095)(93000095)(100000703101)(100105400095)(3002001)(3231020)(10201501046)(201708071742011)(100000704101)(100105200095)(100000705101)(100105500095);SRVR:CY4PR1201MB2469;BCL:0;PCL:0;RULEID:(100000800101)(100110000095)(100000801101)(100110300095)(100000802101)(100110100095)(100000803101)(100110400095)(100000804101)(100110200095)(100000805101)(100110500095);SRVR:CY4PR1201MB2469;
X-Microsoft-Exchange-Diagnostics-untrusted: 1; DM5PR12MB1275;
 4:ishSlj4zqTm/iYrmDgyfVAhmqDO/qdk2fzQWhxzh8Qkook4kGB9y5338m/xfV49mprIrdLszsat/QZd2cr7f35LMOIxijNuHq+ZIWiF3YEeogy21R6gTJY3VDTTJzFBkR87+fXBbhFIXYqQUsK6T2+bLdaBZVHjT9Ze6rPFEw7WsytVWyZyrQ7QNdfPFNAKYeLozjHbS4jzkGcBlFmge1VqbUa9VWW6HOfAcMvgUbyJuuQlsPHdmGEaWFEPx6l1PDW/BHjE7+Zh6vMG1Ib3WfALUaHdqa5156A1GXYS7r5EkYijJippjEgzL8KZymaK1QVg5WQOQSxYE/zVO2wI4kL+01xvEBRvnDQ6nvhUNKug=
X-Forefront-PRVS: 047001DADA
X-Microsoft-Exchange-Diagnostics-untrusted: =?utf-8?B?MTtETTVQUjEyTUIxMjc1OzIzOnJWVHVNTmoyaEtrc3cxWjA0YVNhQ3laczZI?=
 =?utf-8?B?R1ZzTjgrZUE2dExzdkx6MG4xY0RIT21RSWE0OGkwNzVrbW9qTEJkbnE4UzQ0?=
 =?utf-8?B?bVRuVVZEVTZPcGJER1pQb0lZOEZWclJXdEtRZjBzVVhZdmg1K0FueHVhWndT?=
 =?utf-8?B?M2JQTmlxSVlEcXhRNXNQTXhMa21DcHpUdldNZlNoZWNNMmFZK0M3TDlUY0ps?=
 =?utf-8?B?WUk5K2JWN0l5VisxOUNRMEJIYnhTUy9vUnc5aHAvSHZaeElIZTlqa05nVUxw?=
 =?utf-8?B?K240NC9lU1U4MW5uSXE1cVlSV2MvS0ZLN0FDVEtvTjNWWmF3WDdzZ2xkMTM5?=
 =?utf-8?B?Q1p4ZTZsU0I4Q3NoQlFyZFF1TURDTnRsVk10ZnZGeFNQd0xiMnEzRW5WTzFY?=
 =?utf-8?B?bVo0MGwwZVpsdllEUW1FcTdTdG15OFFKS0VyRitkVzYzUmdubm1GTi9ja3Bw?=
 =?utf-8?B?Vm5ON0xjb1luaDRCQkg0bEd0cXRsWml5bHNBYWFuVUFsUzRFOS9iOFY1emtr?=
 =?utf-8?B?cG52K0lvMlY4UjV4Zjk4enZrelMzYmg3L05MTzY3cTl0MXhmMVd2NkkzYnRP?=
 =?utf-8?B?UlFyTi9CS0xQVlJnWWRpWmNUTWl3YXlhczRrejlqbGFOcHltZ2FZRWd3Mll3?=
 =?utf-8?B?cGltOWtwRG9vcHN6NjczVDNzVFdyVTdreElxSHMvQkFwUlhVNUg1SkpQZ0sw?=
 =?utf-8?B?L1AxZG0zdjdoNFJrL0c1aklhSzJjaTNsaGdVUlJyczNha2ZxY04rcFRmOUJH?=
 =?utf-8?B?VTYvMXFWUmNpRE5STXA3Ym55SzJLb3RqaTVBK3Z5MnQrU3JONTRPODQ5SHoy?=
 =?utf-8?B?VnVsMU9neWtmWktoK2F1NWphbXZsK3Izbmt6eHdkckZNaDBmMXhlTFhpRis0?=
 =?utf-8?B?dWtqWXNMZkNlS2hXRUwrTkMwTkxmcFl2VXhCbXlaWnFReHRtbUh5L3JOejRh?=
 =?utf-8?B?UXlVYXNaK3gwalc4eUlGbk1BdE9BeUhmYWFXUHRIQ2F0Sno2bkRJakl4ZGQy?=
 =?utf-8?B?dXl3UjFSMUUzRlJib3k2a0FIUTFPRkh2QkZaTU5VeEdmM1hvOTRXdklialJm?=
 =?utf-8?B?N29rT1puVlJLQ1BXMWhnMlRpUGxwM0lSRVdOR1kzbk14cXJFRXFsZmFmZnV2?=
 =?utf-8?B?K3o0S2dQN3MyS3VxVDd1K3ZHVFF0d0ZFRG5Vc3g5MUszaUppWU5qdzlQdFcx?=
 =?utf-8?B?UTNhajdFN0Z2QWtMY3A1bktTWU1lQ0krOXJaSXFLc1ZKYytCLzREVFJzbUpX?=
 =?utf-8?B?WUg4K3hHQURXOFgvd1llbC9LMCswa1lhU3Q0UjdYZUk3K3lOeWh2QTU5ZzM0?=
 =?utf-8?B?cXNpQlRjQzFvTUd5UitKSXN3UTZ3VTduczRCbHFZL2tEVUcvL3FCK2Q0bEZl?=
 =?utf-8?B?TU9pbm1GZFo0UjlBZXA5RkxxMzlIUG94T0lFQ0l1YU1UOWJEOEt0a3hITVlj?=
 =?utf-8?B?WENxUStVUHhyaEJIMnlXbGJMNVNveCt3MEMzTkE4NXJ2Yi9FRnIraFM1NENE?=
 =?utf-8?B?SEpSQU5PMnhRVnRPdU1YRjc3WCtqZXZDY2E3UVJ2RUx6cThhdHhveDRXTyty?=
 =?utf-8?B?WEZmWEpuMHNKR3RON3dHVklYMlpWcU1JclRwOHZMQUZNZk9BSEVTcjBickNl?=
 =?utf-8?B?T1JrZUFwcHlRZVVaTWlLQ0djY2lBVGVmdnBpVVQydGh2SDFlZFo5Qlo3bWVp?=
 =?utf-8?B?ZXVkZ0E3TCtoaVZSeHFIQUg1UThvRkY5K0lPbzhaK0VqM3BwcUJEMXN5Q0tv?=
 =?utf-8?B?aWRJQmdFZHRoelBvYzFZenQrUkdnVkFhRzdHdjNCcTE4MmNwblpNV0lqenJy?=
 =?utf-8?B?TDVRUHV2TnluVVU5bGVLR2w1REZ2aGhqKzBlVG1QRG51ZDd4Qm5RWUtGcXkz?=
 =?utf-8?B?d0cxeGpmOVdzVjh4dHVYK0Q4WnphU09ZME9aZkZzbzJsbFdSc1dSNlUveitX?=
 =?utf-8?Q?t8DYWH8f+Fdg5DMVxBu6JoFbQ+ZQ9o=3D?=
X-Microsoft-Exchange-Diagnostics-untrusted: 1; DM5PR12MB1275;
 6:v3kEkoaYqBi3cUzvB0TVWm1hkbS0rSZAjxPMiLyW4rrF4YfhsYlxuCzXbls20q81zj5+WYu4go4IteKT/06d4awsA2LAOT1XNvYH6dBVBq65d899gMC1E6l9jQjLH/5i9Z50ca5wM/wqXDR2iP9stkBSIiG5n3RoQlhPaLo44AwsNXLq+R5YeQbgHTCfLtFmA813n6B4VDgl330l2IPB2FjJ18ZQjd4V4ktshjp24xN09sPb5q2sUbZvt6+NuXMWNCd+LwboMi3NsUHm8wyj4zgoPzazXB1hqPVhOjpX0Vp4jzrxRvlo/y+RRYKtbH1/DjXXwR3G8lfsVXuLw8tBNg==;
 5:3ditcGhmS0PbyGPz3SCa/GaMrU0TD627cZo4hjJsJndQA62sqhyInZD7YtupKHVJfEUYhrbKyGCQ8c31uYk7beujckElZUSzHMAhwmyfgCJxmqEh4nWuIm/N9061xLSiapDMKWyw8Dka3FYI7kKS1QU7z83h+pY7u3w4xT/QFXQ=;
 24:hYZV+5jvozwDlosGdq0KPlPQTeNjAgfbxeXLCkkGQaSFnAnCTxdhxOJwQGBEoSTy+wRloL1SKj47rPoqAWoTrvR19deR1u41nEY3U7PeoEs=;
 7:+kR8+qEaiiIjHVtPhdtuDXGMspk6suV0k47ssFX0N8q//JG34Qk1hiR1eqCjlMYsDvAjlOKZLKmbiaeDjzSf1wE2xfvbTcvaVzxutv6xnQwD3iMvrjG/pzW2AyXMB/xpb3E/HOU7vb6YJebLxSjrpi+l4weVFanyjOTtSEj7O5lzTVRPmvNYpEKEYuBA40qvVTVoTyHwlSP/UBO8f8FmFekPJRg1rDtYDiiAcrTD4EY=
SpamDiagnosticOutput: 1:2
SpamDiagnosticMetadata: a13811e2228e4014ba0cf06b473c0502
X-Microsoft-Exchange-Diagnostics-untrusted: 1; DM5PR12MB1275;
 20:s0aWbwle4fN1iCqRW6reZzWkZNse8MFy1TZFV53eP9zaCNRm9ZztkS9ufFeCRC6nv02vMu6iSYAa05pivEIPL/cURkiCGBFtuOF0Y2KCLvwQe1Rr2yFBrt6X3Hn8eNO6qSVTYulR0Hb5/YG67DH0cOWivJb9OL0WuRjhviG6DeIHemLNGFI/iMfwcsUJtY/3CmN8wEA0u63BKTu6xq8YhYlFOcqYmZzA8AdNB3/gMxGleuxwdVjj+8wOAsTkZMdH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1275
X-BeenThere: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
X-Mailman-Version: 2.1.18
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; format=flowed
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Return-Path: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
X-MS-Exchange-Organization-Network-Message-Id: c5be1ad3-80ea-442b-a8ea-08d51ac774a8
X-EOPTenantAttributedMessage: 3dd8961f-e488-4e60-8e11-a82d994e183d:0
X-MS-Exchange-Organization-MessageDirectionality: Incoming
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DM3NAM03FT013.eop-NAM03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:131.252.210.177;IPV:NLI;CTRY:US;EFV:NLI;SFV:SKN;SFS:;DIR:INB;SFP:;SCL:-1;SRVR:CY4PR1201MB2469;H:gabe.freedesktop.org;FPR:;SPF:None;LANG:en;;SKIP:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT013;1:g3QNP7uK7MFsyAxp+g9hBZ9Q0OSXfD/stQJOwLXO2HRV4GQkQzp9fMZtcMVgNypUgvPppqYtyi8yIPg7TYPs0HFJ/XUCmrrSyVLrjio06OKCfeZWMcuOtqUCzBId+80X
X-DkimResult-Test: Failed
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(23075)(22001)(3002016)(4534020)(71702078);SRVR:CY4PR1201MB2469;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2469;3:FiYvh082dfZd5HERkiFrfEM1Tq5ysmGRJrRA7wd6sG0tAM1a68hwCsaob/ut3gkyJtOwqDZRfsx5pRfmREsD046I+yF/9cEfiaaWaWU7Aw057xrqHsSW7XfN+qM74iLMU6OwiZIm6+z3RDKxKgoexCEkvJ9Rf7dM1RhQpBokyMKZNzyag1tIPF19JgptCAS4U8BQ9hreVXC6ivrBQX/v4c1+s6GKi+wB+3AyqddR0TwBvXbByN9w5vr35n36r/Lur6pXEXSo5Y1rBx3o8ouYpH+E51bn+s/WxJAitgngAr7l/kjoGADOkpdmMzSDV1DDmyPfD+DHHndOoHnRdyIzVXhsbF3RpoYelUnxDr5MTbs=;25:EuYFnPen5e0OIIsGRZniOK2BcIBdfecXuWrzQQsSrH7Ypp4ziD67TzDyjN5FDWMFsYQUXjQRY2BAqKhjFmRxl8tCnoksTtd+1W85kHwjm2F+EpZ/25bbTzPg6phNlGXdPRlY2Wgoe0z4TM0/p+64eYdqSnhKoUsW3alvYO4xmszNGxa0ars7fzjMtMuiLccMjHIiroiO8H/4yeho/I5n1X+1NkEPwUwegO3hAziqiVXIouGP85Fyk0oEGatVuNx7CLgirwyi22yCd8TDyakTDF10o3vgoFGS1Y8KgyIGiIDxN8qi8MdxsITZ2vBkVo++w0NU58zrB61sIPFNCO9VGQ==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2469;31:fMyOwUGjlyS2vc13s/EZNWQC9wY4XHXWsPbPf6t+dAmuvaaTRGzgpP5/fiYlxwCamst0E9TpFqwJAy/etzjWJEKMn3EeGVYnxZG2PV4eBudDmDh0bBTheawOrPxMIQBgC/tVPv5VFVbsbdNjNlJvWO00S6TfbpuPfVCgdvXWfqvYTt4ZrfhMHuHL0AlzYKpG1Xo59fxgfp9W1CKkMHrD85qETAjA9AkShIuSEgXb6xA=;20:bRArZLhqERzIubYXnpTs9CehWbl1d3fo99GSAfQqnyrxCgy4ydfcSDdzJcvY1cm5gyQ1peHIrKGY8cq5xU9qbzohMhwhI9HFAhSdG/s+jVHc+s4WZrBOJomeaMd8ouX8qzJtYdWoITdLlHtoterJTG9qumPO7CfRuAc+bzrJWXMzgqBj9zDTof5eCVO0Mq+0cR1YsUPGA0wUhyc3GrPy8GmvFnh9OzPlBjUaEfc4KD/GoGNz/jwJpGxgy8a027G+5CgnXpqgt9xqkeiHS6+HMsDSp2wm1oGPoosTBBeUHkNABJ2ChhGQzmkBC0V09C1z8g4v/My4z0MB6YkJVd9HrdtotEkURmhLSslbPa8osA0s4x202i3OxilOYSna/slvGVroQeQKTIKYMSzY7U7VY04QGuvnuNm0rnCs3yhWxxUh912rIx+m23Mol5qWodbhIXy+gNPXVpiwumL53bGOqdIAXrOGJlTHdV+2/AYkG/cVqW+w8kDDnXm88
 eW7FDi1Opfk4+JY9MVD6Ac5Wdiknxh4xQReXlkLb4hLDM0+I88VbzBdLApPQdkfTOll8OCeFnemieNTbG+vAf4ejdYSQ88q6f0yM6+32IAZv04tDoU=
X-MS-Exchange-Organization-SCL: -1
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2469;4:OlaO7JdBxoqK/+sJSHxOLjcrJhKdAa1FKfxtaaNWhCUVP31LnJIg7qwn0KdGpq5GvoFxOdCAqCCSV7NZQq7Wyc2kl2YgiJJ6PZ8DMLxnCmGH5EG079nRBHuJa3J7qmjkN7FNQoYXeHXBWcmBVhksE5tFdZyPTgsbgLTon/AenPxFRTK2s5V/XXqt3JQlpaqFjtLy1d1W3WQRbkMu16nBLwPZpL1ttnUeGwgBIA4vV9iXX8WIuvKmeAMWN2UqeFIEXFd4NjGyr2DmJcsiUZemQMUjXsPVuI7E2lcNHLXVjj3USJxg6D/4/OwD/E+3z2JvlaUVarLcPC5oGOukNu1TXs03vtAY0I+KUqZZ3qztDnA=;23:BApMCnmCvnKj+ODGG+HYNqDrd7sXL67UIWs9nUxTsL64GaX8J9y3xXyaIrm3bspQoPtg2E1XQ+Z/32NaQ5FI0GSf4Z5QPZsZquuDkzHGkuY8oWt6MD+It0MUfxh9ua5+JyXsrgVNTtCM+4HLNHFo5GrFsOuo9Y2Lq/wrGvvreX8pUcbsrnIGi6XcVg2Igmsd;6:KnXq3lNPm2Qne8p3rENnchmlGjcWuwk20YyKnHJSFSeshBfgt+LTbZIfKnkuzHtpiuODo75PC759OOOuyDW+9LMCkab+s7efY9PedhYcqIVzRASp5gkn/da4H7PLmnvigxUgcaaugXnS8O+eHsn8rgXDYdeIqhIQq6ChpiOYUpiuffrJlYofKjC
 fXKnkL4AXpOJQ4O+f4uYrmsYEgfZvKr+uxjMR4+WxWva431RfOufq1k2060Dn9LH2zqmSznK2zJqtmgZaLxCjM10nJUeXRa2mROuP+5CJ+HwdpboFhj7jrtb02dZ0N7sTP0vBFmNDjCnXOwFEc00RYT4+r2K+zg==
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB2469;5:wv2YSSMe7sTgW2xY+aua/CV+4aWckhPRFnKmjnyMzVu6eSCvgyIuf98Zhtre6SX/C3eVIiKSCsR8f11ciCXcU/ABFzHXWJo0ynPpJm4VUxZj4LW+99s5rpeJifvaNt/ouvt8W7EgREDOl927do5M9tEcwegBGzSpGDOCJl1g7J0=;24:ywhKprKztBV6MIp2PvmFYKeNAHqw70YqBL0+0X09Me3HhgxJfFqKYlKBzgRg1I1DXHwYkR8hT9vHZZhpRrdK/i5UgmQ3596lYxGLo5lZbso=;7:lilVogqIt0aDko4kSku+n4+KX2B8iDoydEwywbYAWIxNLsVuYIyquCSAFhfe1jU3B8M2YDxb3He2LmS6nxKKnHhS5C/G56Wz/qNZkKGk6g0FQid/zqH2H+G78iIj6NGzg5Xw2OJ7RuaQkpnZb43YGQRTZMUQihSNYCn89m7TyyC1aXL/IXqcH0mjJpr0C3XQMdvjrcdtrvMAOH3SIn4vvoWxCZl6pZx8kr4Cjvz73E0=;20:YtzhWB+8RfQPxkjnrFcz5i+Of3l2Ais+hxw0oOeSnXGe9ApdBQv/vYEdxtTShn8Vg1y2kzAc+OwmxnlrSvp2ZgJHv8TBsoxrDQ1QxQxY1cEmL4pW9FAY+QkWbwkhQ++8oy9d7QBDigD/bJ+9J2x58hPDHDiVnWRE8KPmpfK47Ozv0cAnFUn2p6DJf8lktINMHkhrWTQxhFRKnJeZo5gHQewBw8m
 cZ1tjfnn+qjtpZ+OK4D91ZHb5KAcrpzWF9fF0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2017 10:10:28.0170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5be1ad3-80ea-442b-a8ea-08d51ac774a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2469
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0198;23:IPrtnyz7GctghIz+22TR+gyf3lvzAda3aoigzrkM8hCSl7YUx0KmaoMVAsPlu7BUYmm2D30Z4piK5WTZeCgFHcaNDgbIrzef3hwLNDMZY5jv+A32qrCBdTxCu+GxhP8HQfeDSnnLN+Nrd20YU0I9YM6XlNklMH7upGC0Fx408qh7Y7f2KJAIW9sDdAluavS7
X-MS-Exchange-Organization-AuthSource: DM3NAM03FT013.eop-NAM03.prod.protection.outlook.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Transport-EndToEndLatency: 00:00:05.1968528
X-MS-Exchange-Processed-By-BccFoldering: 15.20.0156.006
X-Microsoft-Exchange-Diagnostics: 1;MWHPR1201MB0206;27:j23uzJT9vtV3TNNnKPYAZSEUVQCn1SRnk04rkXP5gzMtYwkucSuoHwCM4+UWtnNwdGld5o90TNOTGqqVX4V3jsphAJIqHoBy3ZD9p5R263Gi01M1Gl+ZYAII8cLGL+Sk
MIME-Version: 1.0

SGkgTW9uaywKCllvdSBjYW4gZW5hYmxlIEtBU0FOIHRvIGNhdGNoIHVzZS1hZnRlci1mcmVlIGNh
c2UgYnkgJ0NPTkZJR19LQVNBTiA9IHknLCAKd2hpY2ggY2FsbHRyYWNlIHJlYWxseSBpcyB2ZXJ5
IGdvb2QgYW5kIG9idmlvdXMuCgpSZWdhcmRzLAoKRGF2aWQgWmhvdQoKCk9uIDIwMTflubQxMOac
iDI05pelIDE4OjA2LCBMaXUsIE1vbmsgd3JvdGU6Cj4gQ2hyaXN0aWFuCj4KPiBBY3R1YWxseSB0
aGVyZSBhcmUgbW9yZSB3aWxkIHBvaW50ZXIgaXNzdWUgZm9yIGVudGl0eSBpbiBzY2hlZHVsZXIn
cyBtYWluIHJvdXRpbmUgLi4uLgo+Cj4KPiBTZWUgdGhlIG1lc3NhZ2UgSSByZXBsaWVkIHRvIERh
dmlkCj4KPiBCUiBNb25rCj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+IEZyb206IGFt
ZC1nZnggW21haWx0bzphbWQtZ2Z4LWJvdW5jZXNAbGlzdHMuZnJlZWRlc2t0b3Aub3JnXSBPbiBC
ZWhhbGYgT2YgQ2hyaXN0aWFuIEs/bmlnCj4gU2VudDogMjAxN+W5tDEw5pyIMjTml6UgMTg6MDEK
PiBUbzogWmhvdSwgRGF2aWQoQ2h1bk1pbmcpIDxEYXZpZDEuWmhvdUBhbWQuY29tPjsgYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBTdWJqZWN0OiBSZTogW1BBVENIXSBkcm0vYW1kL3Nj
aGVkdWxlcjogZml4IG9uZSB1c2VkLWFmdGVyLWZyZWUgY2FzZSBmb3Igam9iLT5zX2VudGl0eQo+
Cj4gQW5kcmV5IGFscmVhZHkgc3VibWl0dGVkIGEgZml4IGZvciB0aGlzIGEgZmV3IGRheXMgYWdv
Lgo+Cj4gQ2hyaXN0aWFuLgo+Cj4gQW0gMjQuMTAuMjAxNyB1bSAxMTo1NSBzY2hyaWViIENodW5t
aW5nIFpob3U6Cj4+IFRoZSBzX2VudGl0eSBwcmVzZW50ZWQgcHJvY2VzcyBjb3VsZCBhbHJlYWR5
IGJlIGNsb3NlZCB3aGVuIGNhbGxpbmcgYW1kZ3B1X2pvYl9mcmVlX2NiLgo+PiB0aGUgc19lbnRp
dHkgd2lsbCBiZSBidWdneSBwb2ludGVyIGFmdGVyIGl0J3MgZnJlZWQuIFNlZSBiZWxvdyBjYWxs
dHJhY2U6Cj4+Cj4+IFsgIDM1NS42MTY5NjRdCj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+PiBbICAzNTUuNjE3MTkx
XSBCVUc6IEtBU0FOOiB1c2UtYWZ0ZXItZnJlZSBpbgo+PiBhbWRncHVfam9iX2ZyZWVfY2IrMHgy
Zi8weGMwIFthbWRncHVdIFsgIDM1NS42MTcxOTddIFJlYWQgb2Ygc2l6ZSA4IGF0Cj4+IGFkZHIg
ZmZmZjg4MDM5ZDU5M2M0MCBieSB0YXNrIGt3b3JrZXIvOToxLzEwMAo+Pgo+PiBbICAzNTUuNjE3
MjA2XSBDUFU6IDkgUElEOiAxMDAgQ29tbToga3dvcmtlci85OjEgTm90IHRhaW50ZWQKPj4gNC4x
My4wLWN1c3RvbSAjMSBbICAzNTUuNjE3MjA4XSBIYXJkd2FyZSBuYW1lOiBHaWdhYnl0ZSBUZWNo
bm9sb2d5Cj4+IENvLiwgTHRkLiBEZWZhdWx0IHN0cmluZy9YOTlQLVNMSS1DRiwgQklPUyBGMjMg
MDcvMjIvMjAxNiBbCj4+IDM1NS42MTczNDJdIFdvcmtxdWV1ZTogZXZlbnRzIGFtZF9zY2hlZF9q
b2JfZmluaXNoIFthbWRncHVdIFsgIDM1NS42MTczNDRdIENhbGwgVHJhY2U6Cj4+IFsgIDM1NS42
MTczNTFdICBkdW1wX3N0YWNrKzB4NjMvMHg4ZAo+PiBbICAzNTUuNjE3MzU2XSAgcHJpbnRfYWRk
cmVzc19kZXNjcmlwdGlvbisweDcwLzB4MjkwCj4+IFsgIDM1NS42MTc0NzRdICA/IGFtZGdwdV9q
b2JfZnJlZV9jYisweDJmLzB4YzAgW2FtZGdwdV0gWyAgMzU1LjYxNzQ3N10KPj4ga2FzYW5fcmVw
b3J0KzB4MjY1LzB4MzUwIFsgIDM1NS42MTc0NzldICBfX2FzYW5fbG9hZDgrMHg1NC8weDkwIFsK
Pj4gMzU1LjYxNzYwM10gIGFtZGdwdV9qb2JfZnJlZV9jYisweDJmLzB4YzAgW2FtZGdwdV0gWyAg
MzU1LjYxNzcyMV0KPj4gYW1kX3NjaGVkX2pvYl9maW5pc2grMHgxNjEvMHgxODAgW2FtZGdwdV0g
WyAgMzU1LjYxNzcyNV0KPj4gcHJvY2Vzc19vbmVfd29yaysweDJhYi8weDcwMCBbICAzNTUuNjE3
NzI3XSAgd29ya2VyX3RocmVhZCsweDkwLzB4NzIwCj4+IFsgIDM1NS42MTc3MzFdICBrdGhyZWFk
KzB4MThjLzB4MWUwIFsgIDM1NS42MTc3MzJdICA/Cj4+IHByb2Nlc3Nfb25lX3dvcmsrMHg3MDAv
MHg3MDAgWyAgMzU1LjYxNzczNV0gID8KPj4ga3RocmVhZF9jcmVhdGVfb25fbm9kZSsweGIwLzB4
YjAgWyAgMzU1LjYxNzczOF0KPj4gcmV0X2Zyb21fZm9yaysweDI1LzB4MzAKPj4KPj4gWyAgMzU1
LjYxNzc0Ml0gQWxsb2NhdGVkIGJ5IHRhc2sgMTM0NzoKPj4gWyAgMzU1LjYxNzc0N10gIHNhdmVf
c3RhY2tfdHJhY2UrMHgxYi8weDIwIFsgIDM1NS42MTc3NDldCj4+IHNhdmVfc3RhY2srMHg0Ni8w
eGQwIFsgIDM1NS42MTc3NTFdICBrYXNhbl9rbWFsbG9jKzB4YWQvMHhlMCBbCj4+IDM1NS42MTc3
NTNdICBrbWVtX2NhY2hlX2FsbG9jX3RyYWNlKzB4ZWYvMHgyMDAgWyAgMzU1LjYxNzg1M10KPj4g
YW1kZ3B1X2RyaXZlcl9vcGVuX2ttcysweDk4LzB4MjkwIFthbWRncHVdIFsgIDM1NS42MTc4ODNd
Cj4+IGRybV9vcGVuKzB4MzhjLzB4NmUwIFtkcm1dIFsgIDM1NS42MTc5MDhdICBkcm1fc3R1Yl9v
cGVuKzB4MTQ0LzB4MWIwCj4+IFtkcm1dIFsgIDM1NS42MTc5MTFdICBjaHJkZXZfb3BlbisweDE4
MC8weDMyMCBbICAzNTUuNjE3OTEzXQo+PiBkb19kZW50cnlfb3BlbisweDNhMi8weDU3MCBbICAz
NTUuNjE3OTE1XSAgdmZzX29wZW4rMHg4Ni8weGUwIFsKPj4gMzU1LjYxNzkxOF0gIHBhdGhfb3Bl
bmF0KzB4NDllLzB4MWRiMCBbICAzNTUuNjE3OTE5XQo+PiBkb19maWxwX29wZW4rMHgxMWMvMHgx
YTAgWyAgMzU1LjYxNzkyMV0gIGRvX3N5c19vcGVuKzB4MTZmLzB4MmEwIFsKPj4gMzU1LjYxNzky
M10gIFN5U19vcGVuKzB4MWUvMHgyMCBbICAzNTUuNjE3OTI2XQo+PiBkb19zeXNjYWxsXzY0KzB4
ZWEvMHgyMTAgWyAgMzU1LjYxNzkyOF0KPj4gcmV0dXJuX2Zyb21fU1lTQ0FMTF82NCsweDAvMHg2
YQo+Pgo+PiBbICAzNTUuNjE3OTMxXSBGcmVlZCBieSB0YXNrIDEzNDc6Cj4+IFsgIDM1NS42MTc5
MzRdICBzYXZlX3N0YWNrX3RyYWNlKzB4MWIvMHgyMCBbICAzNTUuNjE3OTM2XQo+PiBzYXZlX3N0
YWNrKzB4NDYvMHhkMCBbICAzNTUuNjE3OTM3XSAga2FzYW5fc2xhYl9mcmVlKzB4NzAvMHhjMCBb
Cj4+IDM1NS42MTc5MzldICBrZnJlZSsweDlkLzB4MWMwIFsgIDM1NS42MTgwMzhdCj4+IGFtZGdw
dV9kcml2ZXJfcG9zdGNsb3NlX2ttcysweDFiYy8weDNlMCBbYW1kZ3B1XSBbICAzNTUuNjE4MDYz
XQo+PiBkcm1fcmVsZWFzZSsweDQ1NC8weDYxMCBbZHJtXSBbICAzNTUuNjE4MDY1XSAgX19mcHV0
KzB4MTc3LzB4MzUwIFsKPj4gMzU1LjYxODA2Nl0gIF9fX19mcHV0KzB4ZS8weDEwIFsgIDM1NS42
MTgwNjhdICB0YXNrX3dvcmtfcnVuKzB4YTAvMHhjMAo+PiBbICAzNTUuNjE4MDcwXSAgZG9fZXhp
dCsweDQ1Ni8weDEzMjAgWyAgMzU1LjYxODA3Ml0KPj4gZG9fZ3JvdXBfZXhpdCsweDg2LzB4MTMw
IFsgIDM1NS42MTgwNzRdICBTeVNfZXhpdF9ncm91cCsweDFkLzB4MjAgWwo+PiAzNTUuNjE4MDc2
XSAgZG9fc3lzY2FsbF82NCsweGVhLzB4MjEwIFsgIDM1NS42MTgwNzhdCj4+IHJldHVybl9mcm9t
X1NZU0NBTExfNjQrMHgwLzB4NmEKPj4KPj4gWyAgMzU1LjYxODA4MV0gVGhlIGJ1Z2d5IGFkZHJl
c3MgYmVsb25ncyB0byB0aGUgb2JqZWN0IGF0IGZmZmY4ODAzOWQ1OTNiODAKPj4gICAgICAgICAg
ICAgICAgICAgd2hpY2ggYmVsb25ncyB0byB0aGUgY2FjaGUga21hbGxvYy0yMDQ4IG9mIHNpemUg
MjA0OAo+PiBbICAzNTUuNjE4MDg1XSBUaGUgYnVnZ3kgYWRkcmVzcyBpcyBsb2NhdGVkIDE5MiBi
eXRlcyBpbnNpZGUgb2YKPj4gICAgICAgICAgICAgICAgICAgMjA0OC1ieXRlIHJlZ2lvbiBbZmZm
Zjg4MDM5ZDU5M2I4MCwgZmZmZjg4MDM5ZDU5NDM4MCkKPj4gWyAgMzU1LjYxODA4N10gVGhlIGJ1
Z2d5IGFkZHJlc3MgYmVsb25ncyB0byB0aGUgcGFnZToKPj4gWyAgMzU1LjYxODA5MV0gcGFnZTpm
ZmZmZWEwMDBlNzU2NDAwIGNvdW50OjEgbWFwY291bnQ6MCBtYXBwaW5nOiAgICAgICAgICAobnVs
bCkgaW5kZXg6MHgwIGNvbXBvdW5kX21hcGNvdW50OiAwCj4+IFsgIDM1NS42MTgwOTVdIGZsYWdz
OiAweDJmZmZmMDAwMDAwODEwMChzbGFifGhlYWQpIFsgIDM1NS42MTgwOTldIHJhdzoKPj4gMDJm
ZmZmMDAwMDAwODEwMCAwMDAwMDAwMDAwMDAwMDAwIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDEw
MDBmMDAwZiBbCj4+IDM1NS42MTgxMDNdIHJhdzogZmZmZmVhMDAwZWRiMDYwMCAwMDAwMDAwMjAw
MDAwMDAyIGZmZmY4ODAzYmZjMGVhMDAKPj4gMDAwMDAwMDAwMDAwMDAwMCBbICAzNTUuNjE4MTA1
XSBwYWdlIGR1bXBlZCBiZWNhdXNlOiBrYXNhbjogYmFkIGFjY2Vzcwo+PiBkZXRlY3RlZAo+Pgo+
PiBbICAzNTUuNjE4MTA4XSBNZW1vcnkgc3RhdGUgYXJvdW5kIHRoZSBidWdneSBhZGRyZXNzOgo+
PiBbICAzNTUuNjE4MTEwXSAgZmZmZjg4MDM5ZDU5M2IwMDogZmMgZmMgZmMgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMgZmMKPj4gZmMgZmMgZmMgZmMgWyAgMzU1LjYxODExM10gIGZmZmY4ODAzOWQ1
OTNiODA6IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiCj4+IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZi
IFsgIDM1NS42MTgxMTZdID5mZmZmODgwMzlkNTkzYzAwOiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBm
YiBmYiBmYiBmYiBmYiBmYiBmYiBmYiBmYgo+PiBbICAzNTUuNjE4MTE3XSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgo+PiBbICAzNTUuNjE4MTIwXSAgZmZmZjg4
MDM5ZDU5M2M4MDogZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmIKPj4gZmIgZmIg
ZmIgZmIgWyAgMzU1LjYxODEyMl0gIGZmZmY4ODAzOWQ1OTNkMDA6IGZiIGZiIGZiIGZiIGZiIGZi
IGZiIGZiCj4+IGZiIGZiIGZiIGZiIGZiIGZiIGZiIGZiIFsgIDM1NS42MTgxMjRdCj4+ID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQo+PiBbICAzNTUuNjE4MTI2XSBEaXNhYmxpbmcgbG9jayBkZWJ1Z2dpbmcgZHVlIHRvIGtl
cm5lbCB0YWludAo+Pgo+PiBDaGFuZ2UtSWQ6IEk4ZmY3MTIyNzk2YjhjZDE2ZmMyNmU5YzQwZThk
NGM4MTUzZDY3ZTBjCj4+IFNpZ25lZC1vZmYtYnk6IENodW5taW5nIFpob3UgPGRhdmlkMS56aG91
QGFtZC5jb20+Cj4+IC0tLQo+PiAgICBkcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVf
c2NoZWR1bGVyLmMgfCAgMSArCj4+ICAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dw
dV9zY2hlZHVsZXIuaCB8IDI3ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQo+PiAgICAyIGZp
bGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jCj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5jCj4+IGluZGV4
IDAwN2ZkYmQuLjgxMDFlZDcgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2No
ZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVk
dWxlci9ncHVfc2NoZWR1bGVyLmMKPj4gQEAgLTUzNSw2ICs1MzUsNyBAQCBpbnQgYW1kX3NjaGVk
X2pvYl9pbml0KHN0cnVjdCBhbWRfc2NoZWRfam9iICpqb2IsCj4+ICAgIAlpZiAoIWpvYi0+c19m
ZW5jZSkKPj4gICAgCQlyZXR1cm4gLUVOT01FTTsKPj4gICAgCWpvYi0+aWQgPSBhdG9taWM2NF9p
bmNfcmV0dXJuKCZzY2hlZC0+am9iX2lkX2NvdW50KTsKPj4gKwlqb2ItPnByaW9yaXR5ID0gam9i
LT5zX2VudGl0eS0+cnEgLSBqb2ItPnNjaGVkLT5zY2hlZF9ycTsKPj4gICAgCj4+ICAgIAlJTklU
X1dPUksoJmpvYi0+ZmluaXNoX3dvcmssIGFtZF9zY2hlZF9qb2JfZmluaXNoKTsKPj4gICAgCUlO
SVRfTElTVF9IRUFEKCZqb2ItPm5vZGUpOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9zY2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5oCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9z
Y2hlZHVsZXIvZ3B1X3NjaGVkdWxlci5oCj4+IGluZGV4IGUyMTI5OWMuLjg4MDhlYjEgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuaAo+
PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1bGVyLmgKPj4g
QEAgLTc3LDYgKzc3LDE4IEBAIHN0cnVjdCBhbWRfc2NoZWRfZmVuY2Ugewo+PiAgICAJdm9pZCAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAqb3duZXI7Cj4+ICAgIH07Cj4+ICAgIAo+PiArZW51
bSBhbWRfc2NoZWRfcHJpb3JpdHkgewo+PiArCUFNRF9TQ0hFRF9QUklPUklUWV9NSU4sCj4+ICsJ
QU1EX1NDSEVEX1BSSU9SSVRZX0xPVyA9IEFNRF9TQ0hFRF9QUklPUklUWV9NSU4sCj4+ICsJQU1E
X1NDSEVEX1BSSU9SSVRZX05PUk1BTCwKPj4gKwlBTURfU0NIRURfUFJJT1JJVFlfSElHSF9TVywK
Pj4gKwlBTURfU0NIRURfUFJJT1JJVFlfSElHSF9IVywKPj4gKwlBTURfU0NIRURfUFJJT1JJVFlf
S0VSTkVMLAo+PiArCUFNRF9TQ0hFRF9QUklPUklUWV9NQVgsCj4+ICsJQU1EX1NDSEVEX1BSSU9S
SVRZX0lOVkFMSUQgPSAtMSwKPj4gKwlBTURfU0NIRURfUFJJT1JJVFlfVU5TRVQgPSAtMgo+PiAr
fTsKPj4gKwo+PiAgICBzdHJ1Y3QgYW1kX3NjaGVkX2pvYiB7Cj4+ICAgIAlzdHJ1Y3QgYW1kX2dw
dV9zY2hlZHVsZXIgICAgICAgICpzY2hlZDsKPj4gICAgCXN0cnVjdCBhbWRfc2NoZWRfZW50aXR5
ICAgICAgICAgKnNfZW50aXR5Owo+PiBAQCAtODcsNiArOTksNyBAQCBzdHJ1Y3QgYW1kX3NjaGVk
X2pvYiB7Cj4+ICAgIAlzdHJ1Y3QgZGVsYXllZF93b3JrCQl3b3JrX3RkcjsKPj4gICAgCXVpbnQ2
NF90CQkJaWQ7Cj4+ICAgIAlhdG9taWNfdCBrYXJtYTsKPj4gKwllbnVtIGFtZF9zY2hlZF9wcmlv
cml0eQkJcHJpb3JpdHk7Cj4+ICAgIH07Cj4+ICAgIAo+PiAgICBleHRlcm4gY29uc3Qgc3RydWN0
IGRtYV9mZW5jZV9vcHMgYW1kX3NjaGVkX2ZlbmNlX29wc19zY2hlZHVsZWQ7IEBACj4+IC0xMTgs
MTggKzEzMSw2IEBAIHN0cnVjdCBhbWRfc2NoZWRfYmFja2VuZF9vcHMgewo+PiAgICAJdm9pZCAo
KmZyZWVfam9iKShzdHJ1Y3QgYW1kX3NjaGVkX2pvYiAqc2NoZWRfam9iKTsKPj4gICAgfTsKPj4g
ICAgCj4+IC1lbnVtIGFtZF9zY2hlZF9wcmlvcml0eSB7Cj4+IC0JQU1EX1NDSEVEX1BSSU9SSVRZ
X01JTiwKPj4gLQlBTURfU0NIRURfUFJJT1JJVFlfTE9XID0gQU1EX1NDSEVEX1BSSU9SSVRZX01J
TiwKPj4gLQlBTURfU0NIRURfUFJJT1JJVFlfTk9STUFMLAo+PiAtCUFNRF9TQ0hFRF9QUklPUklU
WV9ISUdIX1NXLAo+PiAtCUFNRF9TQ0hFRF9QUklPUklUWV9ISUdIX0hXLAo+PiAtCUFNRF9TQ0hF
RF9QUklPUklUWV9LRVJORUwsCj4+IC0JQU1EX1NDSEVEX1BSSU9SSVRZX01BWCwKPj4gLQlBTURf
U0NIRURfUFJJT1JJVFlfSU5WQUxJRCA9IC0xLAo+PiAtCUFNRF9TQ0hFRF9QUklPUklUWV9VTlNF
VCA9IC0yCj4+IC19Owo+PiAtCj4+ICAgIC8qKgo+PiAgICAgKiBPbmUgc2NoZWR1bGVyIGlzIGlt
cGxlbWVudGVkIGZvciBlYWNoIGhhcmR3YXJlIHJpbmcKPj4gICAgKi8KPj4gQEAgLTE4Myw3ICsx
ODQsNyBAQCB2b2lkIGFtZF9zY2hlZF9qb2Jfa2lja291dChzdHJ1Y3QgYW1kX3NjaGVkX2pvYiAq
c19qb2IpOwo+PiAgICBzdGF0aWMgaW5saW5lIGVudW0gYW1kX3NjaGVkX3ByaW9yaXR5Cj4+ICAg
IGFtZF9zY2hlZF9nZXRfam9iX3ByaW9yaXR5KHN0cnVjdCBhbWRfc2NoZWRfam9iICpqb2IpCj4+
ICAgIHsKPj4gLQlyZXR1cm4gKGpvYi0+c19lbnRpdHktPnJxIC0gam9iLT5zY2hlZC0+c2NoZWRf
cnEpOwo+PiArCXJldHVybiBqb2ItPnByaW9yaXR5Owo+PiAgICB9Cj4+ICAgIAo+PiAgICAjZW5k
aWYKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4g
YW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+IGh0
dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------3A0ABDFAEB5E3EA502017BE0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------3A0ABDFAEB5E3EA502017BE0--

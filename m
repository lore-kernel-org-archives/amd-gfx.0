From: roger <honghe@amd.com>
Subject: Re: [RFC] Per file OOM badness
Date: Fri, 19 Jan 2018 18:02:12 +0800
Message-ID: <59079b24-ce47-1ddd-6b22-7b5f97408fad@amd.com>
References: <1516294072-17841-1-git-send-email-andrey.grodzovsky@amd.com>
 <20180118170006.GG6584@dhcp22.suse.cz> <20180118171355.GH6584@dhcp22.suse.cz>
 <DM5PR1201MB01216B72BEF121DD25AB7247FDEF0@DM5PR1201MB0121.namprd12.prod.outlook.com>
 <20180119082517.GM6584@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1230191483=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180119082517.GM6584@dhcp22.suse.cz>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Michal Hocko <mhocko@kernel.org>, "He, Roger" <Hongbo.He@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

--===============1230191483==
Content-Type: multipart/alternative;
	boundary="------------895D7552FEADF0C62940E1E0"
Content-Language: en-US

--------------895D7552FEADF0C62940E1E0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2018年01月19日 16:25, Michal Hocko wrote:
> [removed the broken quoting - please try to use an email client which
> doesn't mess up the qouted text]
>
> On Fri 19-01-18 06:01:26, He, Roger wrote:
> [...]
>> I think you are misunderstanding here.
>> Actually for now, the memory in TTM Pools already has mm_shrink which is implemented in ttm_pool_mm_shrink_init.
>> And here the memory we want to make it contribute to OOM badness is not in TTM Pools.
>> Because when TTM buffer allocation success, the memory already is removed from TTM Pools.
>
>     I have no idea what TTM buffers are. But this smells like something
>     rather specific to the particular subsytem. And my main objection here
>     is that struct file is not a proper vehicle to carry such an
>     information. So whatever the TTM subsystem does it should contribute to
>     generic counters rather than abuse fd because it happens to use it to
>     communicate with userspace.
>
    got it. thanks.
>


--------------895D7552FEADF0C62940E1E0
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018年01月19日 16:25, Michal Hocko
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20180119082517.GM6584@dhcp22.suse.cz">
      <pre wrap="">[removed the broken quoting - please try to use an email client which
doesn't mess up the qouted text]

On Fri 19-01-18 06:01:26, He, Roger wrote:
[...]
</pre>
      <blockquote type="cite">
        <pre wrap="">I think you are misunderstanding here.
Actually for now, the memory in TTM Pools already has mm_shrink which is implemented in ttm_pool_mm_shrink_init.
And here the memory we want to make it contribute to OOM badness is not in TTM Pools.
Because when TTM buffer allocation success, the memory already is removed from TTM Pools.  
</pre>
      </blockquote>
      <blockquote>
        <pre wrap="">
I have no idea what TTM buffers are. But this smells like something
rather specific to the particular subsytem. And my main objection here
is that struct file is not a proper vehicle to carry such an
information. So whatever the TTM subsystem does it should contribute to
generic counters rather than abuse fd because it happens to use it to
communicate with userspace.</pre>
      </blockquote>
    </blockquote>
       got it. thanks.<br>
    <blockquote type="cite"
      cite="mid:20180119082517.GM6584@dhcp22.suse.cz">
      <blockquote>
        <pre wrap="">
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------895D7552FEADF0C62940E1E0--

--===============1230191483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============1230191483==--
